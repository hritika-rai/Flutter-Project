class Request {
  final String userId;
  final String requestId;
  final String name;
  final String bloodGroup;
  final int numberOfUnits;
  final DateTime date;
  final String gender;
  final String hospitalName;
  final String location;
  final String phoneNumber;
  final String age;
  final bool accepted;

  Request({
    required this.userId,
    required this.requestId,
    required this.name,
    required this.bloodGroup,
    required this.numberOfUnits,
    required this.date,
    required this.gender,
    required this.hospitalName,
    required this.location,
    required this.phoneNumber,
    required this.age,
    required this.accepted,
  });

  factory Request.fromMap(Map<String, dynamic> data, String requestId, String userId) {
    DateTime parsedDate;
    try {
      parsedDate = DateTime.parse(data['date']);
    } catch (e) {
      print('Error parsing date: $e');
      parsedDate = DateTime.now(); 
    }
    return Request(
      userId: data['userId'],
      requestId: requestId,
      name: data['name'] ?? 'Unknown',
      bloodGroup: data['bloodGroup'] ?? 'Unknown',
      numberOfUnits: data['numberOfUnits'] ?? 0,
      date: parsedDate,
      gender: data['gender'] ?? 'Unknown',
      hospitalName: data['hospitalName'] ?? 'Unknown',
      location: data['location'] ?? 'Unknown',
      phoneNumber: data['phoneNumber'] ?? 'Unknown',
      age: data['age'] ?? 'Unknown',
      accepted: data['accepted'] ?? false,
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
      'gender': gender,
      'hospitalName': hospitalName,
      'location': location,
      'phoneNumber': phoneNumber,
      'age':age,
      'accepted': accepted,
    };
  }
}
