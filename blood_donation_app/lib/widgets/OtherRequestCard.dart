import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/DonationRequestConnection_model.dart';
import '../models/request_model.dart';
import '../models/notification_model.dart';
import '../provider/DonationRequestConnection_provider.dart';
import '../provider/notification_provider.dart';
import '../provider/request_provider.dart';
import '../provider/user_provider.dart';
import '../screens/OtherRequestList.dart';

class OtherRequestCard extends ConsumerWidget {
  final Request request;
  final VoidCallback reloadRequests; 
  OtherRequestCard({Key? key, required this.request, required this.reloadRequests}) : super(key: key);
  

  Future<void> handleAcceptRequest(WidgetRef ref, BuildContext context) async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be logged in to accept requests.')),
      );
      return;
    }
    
    DonationRequestConnection connection = DonationRequestConnection(
      connectionId: '',
      userId: currentUser!.uid, 
      requestId: request.requestId, 
    );

    try {
      final user = await ref.read(userNotifierProvider.notifier).loadUser(currentUser.uid);

      await ref.read(donationRequestConnectionNotifierProvider.notifier).addConnection(connection);

      await ref.read(requestNotifierProvider.notifier).updateRequest(
        Request(
          userId: request.userId,
          requestId: request.requestId,
          name: request.name,
          bloodGroup: request.bloodGroup,
          numberOfUnits: request.numberOfUnits,
          date: request.date,
          gender: request.gender,
          hospitalName: request.hospitalName,
          location: request.location,
          phoneNumber: request.phoneNumber,
          age: request.age,
          accepted: true,
        ),
      );
              
      final notificationId = Uuid().v4();

      Notifications notification = Notifications(
        notificationId: notificationId, 
        userId: request.userId,
        requestId: request.requestId,
        body: 'Your blood donation request has been accepted by ${user?.name}. You can contact at ${user?.contactNumber}',
        timestamp: DateTime.now(),
      );

      await ref.read(notificationNotifierProvider.notifier).addNotification(request.userId, notification);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request accepted successfully.')),
      );

      reloadRequests();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept request: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(request.userId);
    return Card(
      color: Color.fromARGB(255, 255, 250, 250),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 90,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 235, 238),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            request.bloodGroup,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 239, 68, 68),
                            ),
                          ),
                          Text(
                            '${request.numberOfUnits} Unit',
                            style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -5,
                      left: -60,
                      right: 0,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 30,
                        height: 30,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Positioned(
                      top: 3,
                      left: -60,
                      right: 0,
                      child: Icon(
                        Icons.add, 
                        color: Colors.white, 
                        size: 15
                      )
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${request.name}, ${request.gender}',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.people, color: Colors.grey[600], size: 20),
                              SizedBox(width: 5),
                              Text(
                                '${request.age}yr old',
                                style: TextStyle(color: Colors.grey[600], fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.grey[600], size: 20),
                              SizedBox(width: 5),
                              Text(
                                request.location,
                                style: TextStyle(color: Colors.grey[600], fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.phone, color: Colors.grey[600], size: 20),
                              SizedBox(width: 5),
                              Text(
                                request.phoneNumber,
                                style: TextStyle(color: Colors.grey[600], fontSize: 18),
                              ),
                            ],
                          ),                      
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Time Limit: ${DateFormat('dd/MM/yyyy').format(request.date)}',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(), 
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => handleAcceptRequest(ref, context),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 239, 68, 96),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Accept Request",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
}
