import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUser(Users user) async {
    print('In add User');
    try {
      await _firestore.collection('Users').doc(user.userId).set(user.toMap());
      print('added user');
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  Future<Users?> getUser(String userId) async {
    try {
      print('in getUser, userid: '+ userId);
      DocumentSnapshot doc = await _firestore.collection('Users').doc(userId).get();
      print('doc: '+doc.id);
      if (doc.exists) {
        print('in doc.exists');
        return Users.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }

  Future<void> updateUser(Users user) async {
    try {
      await _firestore.collection('Users').doc(user.userId).update(user.toMap());
    } catch (e) {
      print('Error updating user: $e');
    }
  }
}


// class UserRepository {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addUser(Users user) async {
//   print('In add User');
//   try {
//     await _firestore.collection('Users').add(user.toMap());
//   //  await _firestore.collection('Users').doc(user.userId).set(user.toMap());
//     print('added user');
//   } catch (e) {
//     print('Error adding user: $e');
//   }
// }
//   Future<Users?> getUser(String userId) async {
//     DocumentSnapshot doc = await _firestore.collection('Users').doc(userId).get();
//     if (doc.exists) {
//       return Users.fromMap(doc.data() as Map<String, dynamic>, doc.id);
//     }
//     return null;
//   }
// }
