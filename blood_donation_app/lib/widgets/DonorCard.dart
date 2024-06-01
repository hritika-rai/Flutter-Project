import 'package:flutter/material.dart';
import '../models/donor_model.dart';

class DonorCard extends StatelessWidget {
  final Donor donor;

  const DonorCard({Key? key, required this.donor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 250, 250),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 90,
                  width: 75,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 235, 238),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        donor.bloodGroup,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 239, 68, 68),
                        ),
                      ),
                      Text(
                        '${donor.numberOfUnits} Unit',
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -5,
                  left: -60,
                  right: 0,
                  child: Image.asset(
                    'assets/images/logo.png', // Make sure to provide the correct path to your logo
                    width: 30,
                    height: 30,
                    alignment: Alignment.topCenter,
                  ),
                ),
                Positioned(
                  top: 3,
                  left: -60,
                  right: 0,
                  child: Icon(
                    Icons.add, 
                    color: Colors.white, 
                    size: 15
                  ),
                ),
              ],
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${donor.name}, ${donor.gender}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, color: Colors.grey[600], size: 20),
                          SizedBox(width: 5),
                          Text(
                            '${donor.age}yr old',
                            style: TextStyle(color: Colors.grey[600], fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.grey[600], size: 20),
                          SizedBox(width: 5),
                          Text(
                            donor.location,
                            style: TextStyle(color: Colors.grey[600], fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.phone, color: Colors.grey[600], size: 20),
                          SizedBox(width: 5),
                          Text(
                            donor.phoneNumber,
                            style: TextStyle(color: Colors.grey[600], fontSize: 18),
                          ),
                        ],
                      ),                      
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.info,
                color: Colors.blue,
              ),
              onPressed: () {
                // Add functionality here if needed
              },
            ),
          ],
        ),
      ),
    );
  }
}
