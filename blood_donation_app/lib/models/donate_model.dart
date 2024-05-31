import 'package:flutter/material.dart';

class Donor {
  final String userId;
  final String donateId;
  final String name;
  final String bloodGroup;
  final int numberOfUnits;
  final String gender;
  final String location;
  final String phoneNumber;
  final String age;

  Donor({
    required this.userId,
    required this.donateId,
    required this.name,
    required this.bloodGroup,
    required this.numberOfUnits,
    required this.gender,
    required this.location,
    required this.phoneNumber,
    required this.age,
  });

  factory Donor.fromMap(Map<String, dynamic> data, String donateId, String userId) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(data['date']);
    } catch (e) {
      print('Error parsing date: $e');
      parsedDate = DateTime.now();
    }
    return Donor(
      userId: userId,
      donateId: donateId,
      name: data['name'] ?? 'Unknown',
      bloodGroup: data['bloodGroup'] ?? 'Unknown',
      numberOfUnits: data['numberOfUnits'] ?? 0,
      gender: data['gender'] ?? 'Unknown',
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
      'gender': gender,
      'location': location,
      'phoneNumber': phoneNumber,
      'age': age,
    };
  }
}
