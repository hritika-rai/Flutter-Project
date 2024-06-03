// test/model/donation_request_connection_model_test.dart

import 'package:flutter_test/flutter_test.dart';
import '../../lib/models/DonationRequestConnection_model.dart';

void main() {
  group('DonationRequestConnection Model Test', () {
    test('fromMap should return a valid DonationRequestConnection object', () {
      final connectionId = 'c123';
      final data = {
        'userId': 'u123',
        'requestId': 'r123',
      };

      final connection = DonationRequestConnection.fromMap(data, connectionId);

      expect(connection.connectionId, connectionId);
      expect(connection.userId, 'u123');
      expect(connection.requestId, 'r123');
    });

    test('toMap should return a valid map', () {
      final connection = DonationRequestConnection(
        connectionId: 'c123',
        userId: 'u123',
        requestId: 'r123'
      );

      final map = connection.toMap();

      expect(map['connectionId'], 'c123');
      expect(map['userId'], 'u123');
      expect(map['requestId'], 'r123');
    });
  });
}
