import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../provider/user_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  late Future<Users?> _userFuture;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactNumberController = TextEditingController();

  final List<String> bloodGroups = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  String? _selectedBloodGroup;

  final List<String> genders = ['Male', 'Female', 'Other'];
  String? _selectedGender;

  bool _isInitialLoad = true;

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _userFuture = ref.read(userNotifierProvider.notifier).loadUser(currentUser.uid);
    }

    // Add listeners to text controllers
    _nameController.addListener(_onFieldChanged);
    _contactNumberController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    // Handle field changes here
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final updatedUser = Users(
          userId: currentUser.uid,
          name: _nameController.text,
          bloodGroup: _selectedBloodGroup ?? '',
          contactNumber: _contactNumberController.text,
          gender: _selectedGender ?? '',
        );
        ref.read(userNotifierProvider.notifier).updateUser(updatedUser);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: currentUser == null
          ? const Center(child: Text('No user logged in'))
          : FutureBuilder<Users?>(
              future: _userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error fetching user data: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('User information not available'));
                } else {
                  final user = snapshot.data!;
                  if (_isInitialLoad) {
                    _nameController.text = user.name;
                    _selectedBloodGroup = user.bloodGroup;
                    _contactNumberController.text = user.contactNumber;
                    _selectedGender = user.gender;
                    _isInitialLoad = false;
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 150,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/images/header.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              top: 70,
                              child: Text(
                                'Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 21,
                              top: 110,
                              child: Text(
                                'View or update your profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      labelStyle: TextStyle(fontSize: 25),
                                    ),
                                    style: const TextStyle(fontSize: 20),
                                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedBloodGroup,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedBloodGroup = value;
                                      });
                                    },
                                    items: bloodGroups.map((group) {
                                      return DropdownMenuItem<String>(
                                        value: group,
                                        child: Text(group, style: TextStyle(fontSize: 20)),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      labelText: 'Blood Group',
                                      labelStyle: TextStyle(fontSize: 25),
                                    ),
                                    validator: (value) => value == null || value.isEmpty ? 'Please select a blood group' : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: TextFormField(
                                    controller: _contactNumberController,
                                    decoration: const InputDecoration(
                                      labelText: 'Contact Number',
                                      labelStyle: TextStyle(fontSize: 25),
                                    ),
                                    style: const TextStyle(fontSize: 20),
                                    validator: (value) => value?.isEmpty ?? true ? 'Please enter a contact number' : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: DropdownButtonFormField<String>(
                                    value: _selectedGender,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedGender = value;
                                      });
                                    },
                                    items: genders.map((gender) {
                                      return DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender, style: TextStyle(fontSize: 20)),
                                      );
                                    }).toList(),
                                    decoration: const InputDecoration(
                                      labelText: 'Gender',
                                      labelStyle: TextStyle(fontSize: 25),
                                    ),
                                    validator: (value) => value == null || value.isEmpty ? 'Please select a gender' : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: ElevatedButton(
                                    onPressed: _submitForm,
                                    child: const Text('Save'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
    );
  }
}
