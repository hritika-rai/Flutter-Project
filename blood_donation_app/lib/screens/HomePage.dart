import 'package:blood_donation_app/screens/DonatePage.dart';
import 'package:blood_donation_app/screens/RequestList.dart';
import 'package:flutter/material.dart';

import 'ProfilePage.dart';
import 'RequestPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 250, 227, 235),
        title: Text(
          'Donor Connect',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(4,8,0,8),
          child: Image.asset('assets/images/logo.png'), 
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), 
            onPressed: () {
              // Add action for notification icon if needed
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            SizedBox(height: 20),
            Container(
              height: 170,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 237, 232),
                // color: Color.fromARGB(255, 255, 245, 240),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/logo.jpg',
                      height: 100,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'The measure of life is not its DURATION but its DONATION',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ), 
            SizedBox(height: 25),
            ListView(
              shrinkWrap: true,
              children: [
                _buildListItem(context, 'Request', 'assets/images/request.png', RequestPage()),
                SizedBox(height: 20), 
                _buildListItem(context, 'Donate', 'assets/images/logo.png', DonatePage()),
                SizedBox(height: 20), 
                _buildListItem(context, "Peoples's Request", 'assets/images/logo.png', DonatePage()),
              ],
            ),
            SizedBox(height: 20),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                //_buildGridItem(context, 'Blood banks', 'assets/images/bloodbank.png', HomePage()),
                //_buildGridItem(context, 'Hospital', 'assets/images/Hospital.png',HomePage()),
                _buildGridItem(context, 'Donation History', 'assets/images/DonationHistory.png',HomePage()),
                _buildGridItem(context, 'Your Blood Request List', 'assets/images/BloodRequestList.png', RequestList()),
              ],
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
              child: Icon(Icons.home, color: Colors.red,),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context) => FindDonorPage()));
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
              child: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),

      
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String imagePath, Widget page) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
            ),
            SizedBox(height: 10),
            Text(title),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, String imagePath, Widget page) {
      return InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 25
                )
              ),
            ],
          ),
        ),
      );
    }

}
