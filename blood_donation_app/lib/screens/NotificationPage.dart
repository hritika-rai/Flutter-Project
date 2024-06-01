import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';  
import 'package:timeago/timeago.dart' as timeago;  
import '../models/notification_model.dart';
import '../provider/notification_provider.dart';

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
      // Trigger the loading of notifications after the widget has been fully built
      WidgetsBinding.instance.addPostFrameCallback((_) {
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
      // Handle error (e.g., show error message)
      print('Error deleting notification: $e');
    }
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
                    _notificationsLoaded = true; // Mark notifications as loaded
                    if (notifications.isEmpty) {
                      return Center(child: Text('No notifications found.'));
                    }
                    return ListView.builder(
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        return Dismissible(
                          key: Key(notification.notificationId),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          confirmDismiss: (direction) async {
                            // Show a confirmation dialog if needed
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
                              child: ExpansionTile(
                                tilePadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                leading: Icon(Icons.notifications, color: Theme.of(context).primaryColor),
                                title: Text(
                                  notification.body,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  getTimeAgo(notification.timestamp),
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
