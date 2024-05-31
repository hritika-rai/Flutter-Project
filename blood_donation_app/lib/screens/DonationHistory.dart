import 'package:blood_donation_app/models/DonationRequestConnection_model.dart';
import 'package:blood_donation_app/provider/DonationRequestConnection_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/request_model.dart';
import '../provider/request_provider.dart';
import 'DonationCard.dart';

class DonationHistory extends ConsumerStatefulWidget {
  const DonationHistory({Key? key}) : super(key: key);

  @override
  _DonationHistoryState createState() => _DonationHistoryState();
}

class _DonationHistoryState extends ConsumerState<DonationHistory> {
  late Future<List<DonationRequestConnection>> _connectionsFuture;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _connectionsFuture = ref.read(donationRequestConnectionNotifierProvider.notifier).loadConnections(currentUser.uid);
    } else {
      _connectionsFuture = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                child: GestureDetector(
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
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 110,
                child: Text(
                  'View Your Donation History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Expanded(
            child: FutureBuilder<List<DonationRequestConnection>>(
              future: _connectionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final connections = snapshot.data!;
                  if (connections.isEmpty) {
                    return Center(child: Text('No donation history found.'));
                  }

                  return FutureBuilder<List<Request>>(
                    future: _getFilteredRequests(connections),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (snapshot.hasData) {
                        final requests = snapshot.data!;
                        if (requests.isEmpty) {
                          return Center(child: Text('No donation history found.'));
                        }
                        requests.sort((a, b) => a.date.compareTo(b.date));
                        return ListView.builder(
                          itemCount: requests.length,
                          itemBuilder: (context, index) {
                            final request = requests[index];
                            return DonationCard(request: request);
                          },
                        );
                      } else {
                        return Center(
                          child: Text('No donation history found.'),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: Text('No donation history found.'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<Request>> _getFilteredRequests(List<DonationRequestConnection> connections) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final List<String> requestIds = connections.map((connection) => connection.requestId).toList();
      final List<Request> requests = await ref.read(requestNotifierProvider.notifier).loadRequests(currentUser.uid);
      return requests.where((request) => requestIds.contains(request.requestId)).toList();
    }
    return [];
  }
}
