import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blood_donation_app/provider/user_provider.dart';
import 'package:blood_donation_app/models/user_model.dart';
import 'package:blood_donation_app/repo/user_repo.dart';

import 'package:firebase_auth_mocks/firebase_auth_mocks.dart'; // This is just for mocking FirebaseAuth for testing
void main() {
  test('UserNotifier add user test', () async {
    // Create a test container
    final container = ProviderContainer();

    // Obtain the user notifier provider from the container
    final userNotifier = container.read(userNotifierProvider.notifier);

    // Create a sample user
    final sampleUser = Users(
      userId: 'sampleUserId',
      name: 'John Doe',
      bloodGroup: 'A+',
      contactNumber: '1234567890',
      gender: 'Male',
    );

    // Add the sample user
    await userNotifier.addUser(sampleUser);

    // Get the added user from the state
    final addedUser = container.read(userNotifierProvider);

    // Verify if the added user is in the state
    addedUser.when(
      data: (user) {
        expect(user, sampleUser);
      },
      loading: () {
        fail('Unexpected loading state');
      },
      error: (error, stackTrace) {
        fail('Unexpected error state: $error');
      },
    );

    // Dispose the test container
    container.dispose();
  });
}

