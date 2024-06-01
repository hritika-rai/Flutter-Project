import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  final String userId;
  final String notificationId;  
  final String body;
  final DateTime timestamp;

  Notifications({
    required this.notificationId, 
    required this.userId,
    required this.body,
    required this.timestamp,
  });

  factory Notifications.fromMap(String notificationId, Map<String, dynamic> map) {
    return Notifications(
      notificationId: notificationId,
      userId: map['userId'],
      body: map['body'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationId':notificationId,
      'userId': userId,
      'body': body,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
