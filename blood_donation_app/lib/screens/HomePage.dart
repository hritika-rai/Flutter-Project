import 'package:flutter/material.dart';

import 'ProfilePage.dart';

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
              height: 200,
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
            SizedBox(height: 30),
            // SizedBox(
            //   height: 100,
            //   width: 500,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Handle request button press
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Image.asset(
            //           'assets/images/request.png',
            //           height: 60,
            //           width: 60,
            //         ),
            //         SizedBox(width:20),
            //         Text(
            //           'Request',
            //           style: TextStyle(
            //             fontSize: 25
            //           ),
            //         ),
            //       ],
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10), 
            //       ),
            //       backgroundColor: Colors.white,
            //       elevation: 5,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 100,
              width: 500,
              child: InkWell(
                onTap: () {
                  // Handle request button press
                },
                child: Material(
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      //border: Border.all(),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.5),
                      //     spreadRadius: 2,
                      //     blurRadius: 5,
                      //   ),
                      // ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/request.png',
                          height: 60,
                          width: 60,
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Request',
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            GridView(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              children: [
                _buildGridItem(context, 'Blood banks', 'assets/images/bloodbank.png'),
                _buildGridItem(context, 'Hospital', 'assets/images/Hospital.png'),
                _buildGridItem(context, 'Donation History', 'assets/images/DonationHistory.png'),
                _buildGridItem(context, 'Blood Request List', 'assets/images/BloodRequestList.png'),
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

  Widget _buildGridItem(BuildContext context, String title, String imagePath) {
    return InkWell(
      onTap: () {
        // Handle grid item tap
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
}
