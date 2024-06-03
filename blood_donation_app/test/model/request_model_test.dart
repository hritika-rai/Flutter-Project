import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/request_model.dart';

void main() {
  group('Request Model Test', () {
    test('fromMap should return a valid Request object', () {
      final userId = 'u123';
      final requestId = 'r123';
      final data = {
        'userId': userId,
        'name': 'John Doe',
        'bloodGroup': 'A+',
        'numberOfUnits': 2,
        'date': DateTime.now().toIso8601String(),
        'gender': 'Male',
        'hospitalName': 'Hospital ABC',
        'location': 'City XYZ',
        'phoneNumber': '1234567890',
        'age': '30',
        'accepted': true,
      };

      final request = Request.fromMap(data, requestId, userId);

      expect(request.userId, userId);
      expect(request.requestId, requestId);
      expect(request.name, 'John Doe');
      expect(request.bloodGroup, 'A+');
      expect(request.numberOfUnits, 2);
      expect(request.date, isInstanceOf<DateTime>());
      expect(request.gender, 'Male');
      expect(request.hospitalName, 'Hospital ABC');
      expect(request.location, 'City XYZ');
      expect(request.phoneNumber, '1234567890');
      expect(request.age, '30');
      expect(request.accepted, true);
    });

    test('toMap should return a valid map', () {
      final request = Request(
        userId: 'u123',
        requestId: 'r123',
        name: 'John Doe',
        bloodGroup: 'A+',
        numberOfUnits: 2,
        date: DateTime.now(),
        gender: 'Male',
        hospitalName: 'Hospital ABC',
        location: 'City XYZ',
        phoneNumber: '1234567890',
        age: '30',
        accepted: true,
      );

      final map = request.toMap();

      expect(map['userId'], 'u123');
      expect(map['requestId'], 'r123');
      expect(map['name'], 'John Doe');
      expect(map['bloodGroup'], 'A+');
      expect(map['numberOfUnits'], 2);
      expect(map['date'], isNotNull);
      expect(map['gender'], 'Male');
      expect(map['hospitalName'], 'Hospital ABC');
      expect(map['location'], 'City XYZ');
      expect(map['phoneNumber'], '1234567890');
      expect(map['age'], '30');
      expect(map['accepted'], true);
    });
  });
}
