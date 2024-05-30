import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/request_model.dart';
import '../provider/request_provider.dart';
import 'HomePage.dart';

class RequestList extends ConsumerStatefulWidget {
  const RequestList({Key? key}) : super(key: key);

  @override
  _RequestListState createState() => _RequestListState();
}

class _RequestListState extends ConsumerState<RequestList> {
  late Future<List<Request>> _requestsFuture;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _requestsFuture = ref.read(requestNotifierProvider.notifier).loadRequests(currentUser.uid);
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
                right: 20,
                top: 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 65,
                child: Text(
                  'Request List',
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
                  'Your requests',
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
              future: _requestsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final requests = snapshot.data!;
                  return ListView.builder(
                    itemCount: requests.length,
                    itemBuilder: (context, index) {
                      final request = requests[index];
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

class RequestCard extends StatelessWidget {
  final Request request;
  const RequestCard({Key? key, required this.request}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Positioned(
              child: Container(
                height: 90,
                width: 75,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 227, 179, 187),
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset('assets/images/logo.png', width: 40, height: 40),
            ),
            Positioned(
              top:30,
              left: 15,
              child: Text(
                '${request.bloodGroup}',
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 239, 68, 96),fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top:60,
              left: 15,
              child: Text(
                '${request.numberOfUnits} Units',
                style: TextStyle(fontSize: 12, color: Color.fromARGB(255, 56, 45, 47), fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 0,
              left: 100,
              child: Text(
                request.name+', '+request.gender,
                style: TextStyle(fontSize: 25, color: Colors.brown, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 38,
              left: 100,
              child: Icon(
                 Icons.person,
                 color: Colors.grey,
                 size: 23,
              ),
            ),
            Positioned(
              top: 36,
              left: 125,
              child: Text(
                request.age+" yrs",
                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 64,
              left: 100,
              child: Icon(
                 Icons.location_city,
                 color: Colors.grey,
                 size: 23,
              ),
            ),
            Positioned(
              top: 64,
              left: 125,
              child: Text(
                request.location,
                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
            Positioned(
              top: 84,
              left: 125,
              child: Text(
                DateFormat.yMMMMd().format(request.date),                
                style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
