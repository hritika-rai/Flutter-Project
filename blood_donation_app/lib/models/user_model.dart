class Users {
  final String userId;
  final String name;
  final String bloodGroup;
  final String contactNumber;
  final String gender;

  Users({
    required this.userId,
    required this.name,
    required this.bloodGroup,
    required this.contactNumber,
    required this.gender,
  });

  factory Users.fromMap(Map<String, dynamic> data, String userId) {
    return Users(
      userId: userId,
      name: data['name'] ?? 'Unknown',
      bloodGroup: data['bloodGroup'] ?? 'Unknown',
      contactNumber: data['contactNumber'] ?? 'Unknown',
      gender: data['gender'] ?? 'Unknown',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'bloodGroup': bloodGroup,
      'contactNumber': contactNumber,
      'gender': gender,
    };
  }
}
