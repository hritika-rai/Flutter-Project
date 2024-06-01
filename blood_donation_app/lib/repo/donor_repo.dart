import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donor_model.dart';

class DonateRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addDonate(Donor donor) async {
    print('In add Donate');
    try {
      await _firestore.collection('Donars').doc(donor.donateId).set(donor.toMap());
      print('added donate');
    } catch (e) {
      print('Error adding donate: $e');
    }
  }

  Future<List<Donor>> getDonates(String userId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Donars')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs.map((doc) => Donor.fromMap(doc.data() as Map<String, dynamic>, doc.id, userId)).toList();
    } catch (e) {
      print('Error fetching user donates: $e');
      return [];
    }
  }

  Future<List<Donor>> getDonorsByBloodGroupAndLocation(String userId, String bloodGroup, String location) async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection('Donars')
        .where('bloodGroup', isEqualTo: bloodGroup)
        .where('location', isEqualTo: location)
        .where('userId', isNotEqualTo: userId)
        .get();
    return querySnapshot.docs.map((doc) => Donor.fromMap(doc.data() as Map<String, dynamic>, doc.id, userId)).toList();
  } catch (e) {
    print('Error fetching donors by blood group and location: $e');
    return [];
  }
}


  Future<void> updateDonate(Donor donor) async {
    try {
      await _firestore.collection('Donars').doc(donor.donateId).update(donor.toMap());
    } catch (e) {
      print('Error updating donate: $e');
    }
  }
}
