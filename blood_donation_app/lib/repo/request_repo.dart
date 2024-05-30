import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/request_model.dart';

class RequestRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRequest(Request request,) async {
    print('In add Request');
    try {
      await _firestore.collection('Requests').doc(request.requestId).set(request.toMap());
      print('added request');
    } catch (e) {
      print('Error adding request: $e');
    }
  }

  Future<List<Request>> getRequests(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Requests')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => Request.fromMap(doc.data() as Map<String, dynamic>, doc.id, userId)).toList();
    } catch (e) {
      print('Error fetching user requests: $e');
      return [];
    }
  }

  Future<void> updateRequest(Request request) async {
    try {
      await _firestore.collection('Requests').doc(request.requestId).update(request.toMap());
    } catch (e) {
      print('Error updating request: $e');
    }
  }
}