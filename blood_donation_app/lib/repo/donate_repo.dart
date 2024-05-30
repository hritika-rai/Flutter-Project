import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donate_model.dart';

class DonateRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDonate(Donate donate) async {
    print('In add Donate');
    try {
      await _firestore.collection('Donates').doc(donate.donateId).set(donate.toMap());
      print('added donate');
    } catch (e) {
      print('Error adding donate: $e');
    }
  }

  Future<List<Donate>> getDonates(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Donates')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => Donate.fromMap(doc.data() as Map<String, dynamic>, doc.id, userId)).toList();
    } catch (e) {
      print('Error fetching user donates: $e');
      return [];
    }
  }

  Future<void> updateDonate(Donate donate) async {
    try {
      await _firestore.collection('Donates').doc(donate.donateId).update(donate.toMap());
    } catch (e) {
      print('Error updating donate: $e');
    }
  }
}
