// test/model/user_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/user_model.dart';

void main() {
  group('Users Model Test', () {
    test('fromMap should return a valid Users object', () {
      final userId = 'u123';
      final data = {
        'name': 'John Doe',
        'bloodGroup': 'A+',
        'contactNumber': '1234567890',
        'gender': 'Male'
      };

      final user = Users.fromMap(data, userId);

      expect(user.userId, userId);
      expect(user.name, 'John Doe');
      expect(user.bloodGroup, 'A+');
      expect(user.contactNumber, '1234567890');
      expect(user.gender, 'Male');
    });

    test('toMap should return a valid map', () {
      final user = Users(
        userId: 'u123',
        name: 'John Doe',
        bloodGroup: 'A+',
        contactNumber: '1234567890',
        gender: 'Male'
      );

      final map = user.toMap();

      expect(map['name'], 'John Doe');
      expect(map['bloodGroup'], 'A+');
      expect(map['contactNumber'], '1234567890');
      expect(map['gender'], 'Male');
    });
  });
}
