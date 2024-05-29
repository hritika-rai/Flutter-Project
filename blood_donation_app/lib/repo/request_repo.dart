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

  Future<Request?> getRequest(String requestId, String userId) async {
    try {
      print('in getRequest, requestId: ' + requestId);
      DocumentSnapshot doc = await _firestore.collection('Requests').doc(requestId).get();
      print('doc: ' + doc.id);
      if (doc.exists) {
        print('in doc.exists');
        return Request.fromMap(doc.data() as Map<String, dynamic>, doc.id, userId);
      }
    } catch (e) {
      print('Error fetching request: $e');
    }
    return null;
  }

  Future<void> updateRequest(Request request) async {
    try {
      await _firestore.collection('Requests').doc(request.requestId).update(request.toMap());
    } catch (e) {
      print('Error updating request: $e');
    }
  }
}