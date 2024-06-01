import 'package:flutter/material.dart';

import 'HomePage.dart';
import 'ProfilePage.dart';

class FindDonor2 extends StatefulWidget {
  @override
  _FindDonorState createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor2> {
  final locationController = TextEditingController();
  String? selectedBloodGroup;
  final _formKey = GlobalKey<FormState>(); // Define _formKey here

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/header2.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Find Donor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        'Blood donors around you',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Choose Blood group',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedBloodGroup,
                            hint: Text('Select'),
                            items: <String>[
                              'A+',
                              'A-',
                              'B+',
                              'B-',
                              'O+',
                              'O-',
                              'AB+',
                              'AB-'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedBloodGroup = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextFormField(
                          controller: locationController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your location';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter your location',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Form is validated, perform your search here
                            }
                          },
                          icon: Icon(Icons.search, color: Color.fromARGB(255, 239, 68, 96)),
                          label: Text(
                            'Search',
                            style: TextStyle(color: Color.fromARGB(255, 239, 68, 96)),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Icon(Icons.home, ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FindDonor2()));
              },
              child: Icon(Icons.search),
            ),
            label: 'Find Donor',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
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
}
