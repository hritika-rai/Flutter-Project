import 'package:flutter/material.dart';

class Request {
  final String userId;
  final String requestId;
  final String name;
  final String bloodGroup;
  final int numberOfUnits;
  final DateTime date;
  final TimeOfDay time;
  final String gender;
  final String hospitalName;
  final String location;
  final String phoneNumber;

  Request({
    required this.userId,
    required this.requestId,
    required this.name,
    required this.bloodGroup,
    required this.numberOfUnits,
    required this.date,
    required this.time,
    required this.gender,
    required this.hospitalName,
    required this.location,
    required this.phoneNumber,
  });

  factory Request.fromMap(Map<String, dynamic> data, String requestId, String userId) {
    return Request(
      userId: userId,
      requestId: requestId,
      name: data['name'] ?? 'Unknown',
      bloodGroup: data['bloodGroup'] ?? 'Unknown',
      numberOfUnits: data['numberOfUnits'] ?? 0,
      date: DateTime.parse(data['date'] ?? ''),
      time: TimeOfDay.fromDateTime(DateTime.parse(data['time'] ?? '')),
      gender: data['gender'] ?? 'Unknown',
      hospitalName: data['hospitalName'] ?? 'Unknown',
      location: data['location'] ?? 'Unknown',
      phoneNumber: data['phoneNumber'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'requestId': requestId,
      'name': name,
      'bloodGroup': bloodGroup,
      'numberOfUnits': numberOfUnits,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
      'gender': gender,
      'hospitalName': hospitalName,
      'location': location,
      'phoneNumber': phoneNumber,
    };
  }
}