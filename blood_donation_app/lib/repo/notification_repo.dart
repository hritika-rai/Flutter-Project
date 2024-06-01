import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification_model.dart';

class NotificationRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addNotification(String userId, Notifications notification) async {
    try {
      await _firestore.collection('Notifications').doc(notification.notificationId).set(notification.toMap());
      print('added noti');
    } catch (e) {
      print('Error adding notification: $e');
      throw e;
    }
  }

  Future<List<Notifications>> getNotifications(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Notifications')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .get();
      print(querySnapshot);
      return querySnapshot.docs.map((doc) => Notifications.fromMap(doc.id, doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print('Error fetching notifications: $e');
      // You might want to re-throw the error here to propagate it to the caller
      throw e;
    }
  }

  Future<void> deleteNotification(String userId, String notificationId) async {
    try {
      await _firestore.collection('Notifications').doc(notificationId).delete();
      print('deleted notification');
    } catch (e) {
      print('Error deleting notification: $e');
      throw e;
    }
  }
}
