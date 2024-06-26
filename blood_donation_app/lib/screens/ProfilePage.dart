import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../provider/user_provider.dart';
import 'FindDonor.dart';
import 'HomePage.dart';

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

  @override
  void initState() {
    super.initState();
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      _userFuture = ref.read(userNotifierProvider.notifier).loadUser(currentUser.uid);
    }

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
                  if (_selectedBloodGroup == null) _selectedBloodGroup = user.bloodGroup;
                  if (_selectedGender == null) _selectedGender = user.gender;
                  _nameController.text = user.name;
                  _contactNumberController.text = user.contactNumber;

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
                              left: 320,
                              top: 40,
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Back',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25
                                  ),
                                ),
                                
                              ),
                            ),
                            Positioned(
                              right: 15,
                              top: 85,
                              child: ElevatedButton(
                                onPressed: _signOut, 
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white , 
                                ),
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 239, 68, 96),
                                    fontSize: 18,
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: TextStyle(fontSize: 25),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                  style: TextStyle(fontSize: 20),
                                  validator: (value) => value?.isEmpty ?? true ? 'Please enter a name' : null,
                                ),
                                SizedBox(height: 20), 
                                DropdownButtonFormField<String>(
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
                                  decoration: InputDecoration(
                                    labelText: 'Blood Group',
                                    labelStyle: TextStyle(fontSize: 25),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                  validator: (value) => value?.isEmpty ?? true ? 'Please select a blood group' : null,
                                ),
                                SizedBox(height: 20), 
                                TextFormField(
                                  controller: _contactNumberController,
                                  decoration: InputDecoration(
                                    labelText: 'Contact Number',
                                    labelStyle: TextStyle(fontSize: 25),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                  style: TextStyle(fontSize: 20),
                                  validator: (value) => value?.isEmpty ?? true ? 'Please enter a contact number' : null,
                                ),
                                SizedBox(height: 20),
                                DropdownButtonFormField<String>(
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
                                  decoration: InputDecoration(
                                    labelText: 'Gender',
                                    labelStyle: TextStyle(fontSize: 25),
                                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  ),
                                  validator: (value) => value?.isEmpty ?? true ? 'Please select a gender' : null,
                                ),
                                SizedBox(height: 30), 
                                Center(
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
            bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Icon(Icons.home),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FindDonor()));
                  },
                  child: Icon(Icons.search),
                ),
                label: 'Find Donor',
              ),
              BottomNavigationBarItem(
                icon: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                  },
                  child: Icon(Icons.person, color: Colors.red,),
                ),
                label: 'Profile',
              ),
        ],
      ),
    

    );
  }

  void _signOut() async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  } catch (e) {
    print('Error signing out: $e');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Failed to sign out: $e'),
    ));
  }
}

}

