import 'package:flutter/material.dart';

class Donate {
  final String userId;
  final String donateId;
  final String name;
  final String bloodGroup;
  final int numberOfUnits;
  final DateTime date;
  final String gender;
  final String hospitalName;
  final String location;
  final String phoneNumber;
  final String age;

  Donate({
    required this.userId,
    required this.donateId,
    required this.name,
    required this.bloodGroup,
    required this.numberOfUnits,
    required this.date,
    required this.gender,
    required this.hospitalName,
    required this.location,
    required this.phoneNumber,
    required this.age,
  });

  factory Donate.fromMap(Map<String, dynamic> data, String donateId, String userId) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(data['date']);
    } catch (e) {
      print('Error parsing date: $e');
      parsedDate = DateTime.now();
    }
    return Donate(
      userId: userId,
      donateId: donateId,
      name: data['name'] ?? 'Unknown',
      bloodGroup: data['bloodGroup'] ?? 'Unknown',
      numberOfUnits: data['numberOfUnits'] ?? 0,
      date: parsedDate,
      gender: data['gender'] ?? 'Unknown',
      hospitalName: data['hospitalName'] ?? 'Unknown',
location: data['location'] ?? 'Unknown',
phoneNumber: data['phoneNumber'] ?? 'Unknown',
age: data['age'] ?? 'Unknown',
);
}

Map<String, dynamic> toMap() {
return {
'userId': userId,
'donateId': donateId,
'name': name,
'bloodGroup': bloodGroup,
'numberOfUnits': numberOfUnits,
'date': date.toIso8601String(),
'gender': gender,
'hospitalName': hospitalName,
'location': location,
'phoneNumber': phoneNumber,
'age': age,
};
}
}
