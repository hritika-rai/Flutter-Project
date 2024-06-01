import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/donor_model.dart';
import '../provider/donor_provider.dart';
import '../widgets/DonorCard.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';

class FindDonor extends ConsumerStatefulWidget {
  @override
  _FindDonorPageState createState() => _FindDonorPageState();
}

class _FindDonorPageState extends ConsumerState<FindDonor> {
  String? _bloodGroup;
  String? _location;
  List<Donor>? _donors;
  bool _isLoading = false;

  final List<String> _bloodGroups = [
    'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
  ];

  final List<String> _locations = [
    'Karachi', 'Lahore', 'Islamabad', 'Rawalpindi', 'Peshawar', 
    'Quetta', 'Multan', 'Faisalabad', 'Sialkot', 'Hyderabad'
  ];

  final _formKey = GlobalKey<FormState>(); // Initialize form key

  void _findDonors(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final donors = await ref
            .read(donateNotifierProvider.notifier)
            .loadDonorsByBloodGroupAndLocation('currentUserId', _bloodGroup!, _location!);
        _donors = donors;
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching donors: $error')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              //height: 500,
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
                child: Form( 
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      Text(
                        'Find Donor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Blood donors around you',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Text(
                        'Choose Blood group',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _bloodGroup,
                            hint: Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            items: _bloodGroups.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _bloodGroup = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        'Location',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _location,
                            hint: Text(
                              'Select',
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                            items: _locations.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 24.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _location = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: () => _findDonors(context), // Pass context
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
            ),
            SizedBox (height: 20.0),
            _isLoading
              ? Center(child: CircularProgressIndicator())
              : _donors == null || _donors!.isEmpty
                ? Center(child: Text('No donors found'))
                : Column(
                    children: _donors!.map((donor) => DonorCard(donor: donor)).toList(),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FindDonor()));
              },
              child: Icon(Icons.search, color: Colors.red),
            ),
            label: 'Find Donor',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

