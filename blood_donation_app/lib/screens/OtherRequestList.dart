import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/request_model.dart';
import '../provider/request_provider.dart';
import 'RequestCard.dart';

class OtherRequestList extends ConsumerStatefulWidget {
  const OtherRequestList({Key? key}) : super(key: key);

  @override
  _OtherRequestListState createState() => _OtherRequestListState();
}

class _OtherRequestListState extends ConsumerState<OtherRequestList> {
  late Future<List<Request>> _requestsFuture;
  String _filter = "All"; // Initially show all requests

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
                  'Request',
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
                  'Your request will be displayed to all the donors',
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
                  final requests = snapshot.data!;
                  List<Request> filteredRequests = [];
                  if (_filter == 'All') {
                    filteredRequests = requests;
                  } else if (_filter == 'Accepted') {
                    filteredRequests = requests.where((request) => request.accepted == true).toList();
                  } else if (_filter == 'Pending') {
                    filteredRequests = requests.where((request) => request.accepted == false).toList();
                  }
                  if (filteredRequests.isEmpty) {
                    return Center(
                      child: Text(_filter == 'All'
                          ? 'No requests found.'
                          : _filter == 'Accepted'
                              ? 'No accepted requests found.'
                              : 'No pending requests found.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: filteredRequests.length,
                    itemBuilder: (context, index) {
                      final request = filteredRequests[index];
                      return RequestCard(request: request);
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
}

