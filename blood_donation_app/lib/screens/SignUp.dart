import 'package:blood_donation_app/screens/UserInfo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/loading.dart';
import 'HomePage.dart';
import 'Login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String confirmPassword;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    confirmPassword = '';
  }

  Future<void> registerWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final UserCredential userCredential = await _auth.signInWithCredential(credential);
        if (userCredential.user != null) {
          print(userCredential.user);
          showLoadingDialog(context);
            await Future.delayed(Duration(seconds: 3)); 
          hideLoadingDialog(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserInfoPage()));
        }
      }
    } catch (e) {
      print('Error registering with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign up with Google: $e'),
      ));
    }
  }

  Future<void> registerWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          showLoadingDialog(context);
            await Future.delayed(Duration(seconds: 3)); 
          hideLoadingDialog(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserInfoPage()));
        }
      } catch (e) {
        print('Error registering with Email: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to sign up with Email: $e'),
        ));
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100),
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.brown[300]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.brown[300]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.red[300],
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color: Colors.brown[300]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.brown, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.red[300],
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please re-enter password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: registerWithEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, 
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          minimumSize: Size(300, 40),
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton.icon(
                  onPressed: registerWithGoogle,
                  icon:  Image.network(
                    'https://cdn-icons-png.flaticon.com/128/281/281764.png',
                    width: 20,
                    height: 20,
                  ),
                  label: Text(
                    'Sign In with Google',
                    style: TextStyle(color: Colors.grey[800], fontSize: 15)
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    minimumSize: Size(300, 40),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account!",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

