import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';  
import 'package:timeago/timeago.dart' as timeago;  
import '../models/notification_model.dart';
import '../provider/notification_provider.dart';
import '../provider/request_provider.dart';  
import '../models/request_model.dart';  

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends ConsumerState<NotificationPage> {
  bool _notificationsLoaded = false;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && !_notificationsLoaded) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        ref.read(notificationNotifierProvider.notifier).loadNotifications(currentUser.uid);
      });
    }
  }

  String getTimeAgo(DateTime date) {
    return timeago.format(date);
  }

  Future<void> _deleteNotification(String userId, String notificationId) async {
    try {
      await ref.read(notificationNotifierProvider.notifier).deleteNotification(userId, notificationId);
    } catch (e) {
      print('Error deleting notification: $e');
    }
  }

  Future<void> _showRequestDetails(String requestId) async {
  try {
    final request = await ref.read(requestNotifierProvider.notifier).loadRequestById(requestId);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Request Details',
            style: TextStyle(
              color: Color.fromARGB(255, 239, 68, 96),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Request ID:', request!.requestId),
              _buildDetailRow('Title:', request.name),
              _buildDetailRow('Blood Group:', request.bloodGroup),
              _buildDetailRow('Units Needed:', request.numberOfUnits.toString()),
              _buildDetailRow('Date:', DateFormat.yMMMd().format(request.date)),
              _buildDetailRow('Gender:', request.gender),
              _buildDetailRow('Hospital:', request.hospitalName),
              _buildDetailRow('Location:', request.location),
              _buildDetailRow('Phone:', request.phoneNumber),
              _buildDetailRow('Age:', request.age),
              _buildDetailRow('Accepted:', request.accepted ? 'Yes' : 'No'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: TextStyle(color: Color.fromARGB(255, 239, 68, 96)),
              ),
            ),
          ],
        );
      },
    );
  } catch (e) {
    print('Error fetching request details: $e');
  }
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(color: Colors.grey[700], fontSize: 18),
          ),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                top: 65,
                child: Text(
                  'Notifications',
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
                  'You can view your notifications here',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Consumer(
              builder: (context, watch, _) {
                final state = ref.watch(notificationNotifierProvider);
                return state.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(child: Text('Error: $error')),
                  data: (notifications) {
                    _notificationsLoaded = true; 
                    if (notifications.isEmpty) {
                      return Center(child: Text('No notifications found.'));
                    }
                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return GestureDetector(
                          onTap: () {
                            _showRequestDetails(notification.requestId); 
                          },
                          child: Dismissible(
                            key: Key(notification.notificationId),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.delete, color: Colors.white),
                            ),
                            confirmDismiss: (direction) async {
                              return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Delete Notification'),
                                    content: Text('Are you sure you want to delete this notification?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(true),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onDismissed: (direction) {
                              _deleteNotification(notification.userId, notification.notificationId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 8,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.notifications, color: Color.fromARGB(255, 239, 68, 96)),
                                      title: Text(
                                        notification.body,
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Text(
                                        getTimeAgo(notification.timestamp),
                                        style: TextStyle(color: Colors.grey, fontSize: 12),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      child: Text(
                                        notification.body,
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                    SizedBox(height: 15,),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
