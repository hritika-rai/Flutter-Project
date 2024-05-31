class DonationRequestConnection {
  final String connectionId; 
  final String userId; 
  final String requestId; 

  DonationRequestConnection({
    required this.connectionId,
    required this.userId,
    required this.requestId,
  });

  factory DonationRequestConnection.fromMap(Map<String, dynamic> data, String connectionId) {
    return DonationRequestConnection(
      connectionId: connectionId,
      userId: data['userId'] ?? '',
      requestId: data['requestId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'connectionId': connectionId,
      'userId': userId,
      'requestId': requestId,
    };
  }
}
