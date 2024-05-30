import 'package:blood_donation_app/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../provider/user_provider.dart';

class UserInfoPage extends ConsumerStatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends ConsumerState<UserInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _locationController = TextEditingController();
  String? _bloodGroup;
  String? _gender;

  @override
  void dispose() {
    _nameController.dispose();
    _contactNumberController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveUserInfo() async {
    if (_formKey.currentState!.validate()) {
      final currentUser = FirebaseAuth.instance.currentUser;
        final user = Users(
          userId: currentUser!.uid,
          name: _nameController.text,
          bloodGroup: _bloodGroup!,
          contactNumber: _contactNumberController.text,
          gender: _gender!,
        );
      

      try {
        await ref.read(userNotifierProvider.notifier).addUser(user);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User information saved successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save user information: $e')),
        );
      }

      Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Your Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Blood Group'),
                value: _bloodGroup,
                items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
                    .map((bg) => DropdownMenuItem(
                          value: bg,
                          child: Text(bg),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _bloodGroup = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your blood group';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactNumberController,
                decoration: const InputDecoration(labelText: 'Contact Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your contact number';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Gender'),
                value: _gender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) {
                  if (value == null) {
                    return 'Please select your gender';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUserInfo,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
