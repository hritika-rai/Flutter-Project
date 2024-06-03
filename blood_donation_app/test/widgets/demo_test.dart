import 'package:blood_donation_app/models/request_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:blood_donation_app/widgets/OtherRequestCard.dart';

// Create a mock FirebaseAuth instance for testing authentication scenarios
class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  group('OtherRequestCard Performance Test', () {
    late MockFirebaseAuth mockFirebaseAuth;

    // Add a setup method to initialize Firebase before running tests
    setUpAll(() async {
      // Initialize Firebase
      await Firebase.initializeApp();
    });

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
    });


    testWidgets('Widget Rendering Performance Test', (WidgetTester tester) async {
      // Build the widget wrapped with MaterialApp
      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: OtherRequestCard(
            request: Request(
              requestId: '123',
              name: 'Test User',
              bloodGroup: 'A+',
              numberOfUnits: 1,
              date: DateTime.now(),
              gender: 'Male',
              hospitalName: 'Test Hospital',
              location: 'Test Location',
              phoneNumber: '1234567890',
              age: '30',
              accepted: false,
              userId: 'u123', // Added userId field
            ),
            reloadRequests: () {},
          ),
        ),
      );

      // Measure the rendering performance
      final Stopwatch stopwatch = Stopwatch()..start();
      await tester.pump();

      // Print the rendering time
      print('Widget rendering time: ${stopwatch.elapsedMilliseconds}ms');
    });

    test('Firebase Interaction Performance Test', () async {
      // Simulate a scenario where a user is logged in
      when(mockFirebaseAuth.currentUser).thenReturn(FirebaseUserMock());

      // Simulate accepting a request
      final otherRequestCard = OtherRequestCard(
        request: Request(
          requestId: '123',
          name: 'Test User',
          bloodGroup: 'A+',
          numberOfUnits: 1,
          date: DateTime.now(),
          gender: 'Male',
          hospitalName: 'Test Hospital',
          location: 'Test Location',
          phoneNumber: '1234567890',
          age: '30',
          accepted: false,
          userId: 'u123', // Added userId field
        ),
        reloadRequests: () {},
      );

      final ref = MockWidgetRef();

      // Measure the time taken to handle accepting the request
      final Stopwatch stopwatch = Stopwatch()..start();
      await otherRequestCard.handleAcceptRequest(ref, MockBuildContext());
      print('Firebase interaction time: ${stopwatch.elapsedMilliseconds}ms');
    });
  });
}

// Mock classes for FirebaseUser and WidgetRef
class FirebaseUserMock extends Mock implements User {}

class MockWidgetRef extends Mock implements WidgetRef {}

class MockBuildContext extends Mock implements BuildContext {}
