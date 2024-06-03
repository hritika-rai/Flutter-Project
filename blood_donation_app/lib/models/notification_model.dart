import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {
  final String userId;
  final String requestId;
  final String notificationId;  
  final String body;
  final DateTime timestamp;

  Notifications({
    required this.notificationId, 
    required this.requestId,
    required this.userId,
    required this.body,
    required this.timestamp,
  });

  factory Notifications.fromMap(String notificationId, Map<String, dynamic> map) {
    return Notifications(
      notificationId: notificationId,
      requestId: map['requestId'],
      userId: map['userId'],
      body: map['body'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'notificationId':notificationId,
      'requestId':requestId,
      'userId': userId,
      'body': body,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
