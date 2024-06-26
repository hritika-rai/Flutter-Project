import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/request_model.dart';
import '../provider/request_provider.dart';
import '../widgets/OtherRequestCard.dart';

class OtherRequestList extends ConsumerStatefulWidget {
  const OtherRequestList({Key? key}) : super(key: key);

  @override
  _OtherRequestListState createState() => _OtherRequestListState();
}

class _OtherRequestListState extends ConsumerState<OtherRequestList> {
  late Future<List<Request>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _requestsFuture = ref.read(requestNotifierProvider.notifier).loadOtherRequests(currentUser.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

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
                  'Requests',
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
                  'You can choose to accept the request',
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
            child: FutureBuilder<List<Request>>(
              future: _requestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final requests = snapshot.data!.where((request) => !request.accepted).toList();
                  if (requests.isEmpty) {
                    return Center(child: Text('No unaccepted requests found.'));
                  }
                  return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];
                      print(request.userId);
                      return OtherRequestCard(
                        request: request,
                        reloadRequests: reloadRequests, 
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('No requests found.'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  void reloadRequests() {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _requestsFuture = ref.read(requestNotifierProvider.notifier).loadOtherRequests(currentUser.uid);
      });
    }
  }
}



