import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/DonationRequestConnection_model.dart';

class DonationRequestConnectionRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addConnection(DonationRequestConnection connection) async {
    try {
      DocumentReference docRef = _firestore.collection('DonationRequestConnections').doc();
      connection = DonationRequestConnection(
        connectionId: docRef.id,
        userId: connection.userId,
        requestId: connection.requestId,
      );
      await docRef.set(connection.toMap());
      print('Added connection');
    } catch (e) {
      print('Error adding connection: $e');
    }
  }

  Future<List<DonationRequestConnection>> getConnections(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('DonationRequestConnections')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => DonationRequestConnection.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      print('Error fetching connections: $e');
      return [];
    }
  }
}
