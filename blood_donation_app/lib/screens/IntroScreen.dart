import 'package:blood_donation_app/screens/SignUp.dart';
import 'package:flutter/material.dart';
import '../widgets/loading.dart';
import 'Login.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/logo.png', height: 200.0),
                  SizedBox(height: 30.0),
                  Text(
                    'DONOR CONNECT',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 50.0),
                  ElevatedButton(
                    onPressed: () async {
                      showLoadingDialog(context);
                      await Future.delayed(Duration(seconds: 2)); 
                      hideLoadingDialog(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      minimumSize: Size(300, 40),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      showLoadingDialog(context);
                      await Future.delayed(Duration(seconds: 3)); 
                      hideLoadingDialog(context);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      minimumSize: Size(300, 40),
                    ),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Image.asset(
              'assets/images/waves.jpg',
              width: MediaQuery.of(context).size.width,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
