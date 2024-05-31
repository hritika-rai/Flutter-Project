import 'package:flutter/material.dart';

class FindDonor extends StatefulWidget {
  @override
  _FindDonorState createState() => _FindDonorState();
}

class _FindDonorState extends State<FindDonor> {
  final bloodGroupController = TextEditingController();
  final locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blood Donor Finder'),
      ),
      body: Container(
        color: Color.fromARGB(255, 239, 68, 96),
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              'Choose blood group:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            DropdownButton<String>(
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
                  child: Text(value, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
              onChanged: (value) {},
              hint: Text('Select Blood Group', style: TextStyle(color: Colors.black)),
            ),
            SizedBox(height: 20.0),
            Text(
              'Location:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            TextFormField(
              controller: locationController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Enter your location',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
