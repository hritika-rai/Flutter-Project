import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/request_model.dart';
import '../models/DonationRequestConnection_model.dart';
import '../repo/request_repo.dart';
import '../repo/DonationRequestConnection_repo.dart';
import '../provider/request_provider.dart';
import '../provider/DonationRequestConnection_provider.dart';
import '../widgets/DonationCard.dart';

class DonationHistory extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser!.uid; 

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/header.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
              Positioned(
                left: 320,
                top: 40,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25
                    ),
                  ),                  
                ),
              ),
              Positioned(
                left: 20,
                top: 65,
                child: Text(
                  'Donation History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 110,
                child: Text(
                  'Your history',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder<List<Request>>(
        future: _loadAcceptedRequests(ref, userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No donation history found.'));
          } else {
            final requests = snapshot.data!;
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return DonationCard(request: request);
              },
            );
          }
        },
      ),
    ),
        ]
  ),
    );
  }

  Future<List<Request>> _loadAcceptedRequests(WidgetRef ref, String userId) async {
    final connectionRepo = ref.read(donationRequestConnectionRepositoryProvider);
    final requestRepo = ref.read(requestRepositoryProvider);

    List<DonationRequestConnection> connections = await connectionRepo.getConnections(userId);

    List<Future<Request?>> requestFutures = connections.map((connection) {
      return requestRepo.getRequestById(connection.requestId);
    }).toList();

    // Await all futures and filter out nulls
    List<Request?> requestList = await Future.wait(requestFutures);
    return requestList.whereType<Request>().toList();
  }
}
