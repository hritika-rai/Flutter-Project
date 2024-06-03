import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blood_donation_app/models/request_model.dart';
import 'package:blood_donation_app/widgets/OtherRequestCard.dart';

void main() {
  testWidgets('Widget Rendering Test', (WidgetTester tester) async {
    Request testRequest = Request(
      bloodGroup: 'A+',
      numberOfUnits: 2,
      name: 'John Doe',
      gender: 'Male',
      age: '30',
      location: 'Test Location',
      phoneNumber: '1234567890',
      date: DateTime.now(),
      accepted: false,
      userId: 'u12e',
      requestId: 'r123',
      hospitalName: 'ABC',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: OtherRequestCard(request: testRequest, reloadRequests: () {}),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('Data Binding Test', (WidgetTester tester) async {
    DateTime testDate = DateTime(2024, 6, 6);
    Request testRequest = Request(
      bloodGroup: 'A+',
      numberOfUnits: 2,
      name: 'John Doe',
      gender: 'Male',
      age: '30',
      location: 'Test Location',
      phoneNumber: '1234567890',
      date: testDate,
      accepted: false,
      userId: 'u12e',
      requestId: 'r123',
      hospitalName: 'ABC',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: OtherRequestCard(request: testRequest, reloadRequests: () {}),
      ),
    );

    expect(find.text('A+'), findsOneWidget);
    expect(find.text('2 Unit'), findsOneWidget);
    expect(find.text('John Doe, Male'), findsOneWidget);
    expect(find.text('30yr old'), findsOneWidget);
    expect(find.text('Test Location'), findsOneWidget);
    expect(find.text('1234567890'), findsOneWidget);
    //expect(find.text('06/06/2024'), findsOneWidget);
  });

  // Add more tests as needed
}
