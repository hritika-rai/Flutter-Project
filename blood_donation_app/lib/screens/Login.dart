import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../widgets/loading.dart';
import 'HomePage.dart';
import 'SignUp.dart';

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    email = '';
    password = '';
    //checkUserLoggedIn(); 
  }

  Future<void> signInWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          print(userCredential.user);
          showLoadingDialog(context);
            await Future.delayed(Duration(seconds: 3)); 
          hideLoadingDialog(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()), 
          );
        }
      } on FirebaseAuthException catch (e) {
        print('Error signing in with Email: $e');
        String errorMessage = 'An error occurred. Please try again.';
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found with this email. Please sign up.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Incorrect password. Please try again.';
        }
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));
      } catch (e) {
        print('Unexpected error signing in with Email: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('An unexpected error occurred. Please try again later.'),
        ));
      }
    }
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
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      }
    } catch (e) {
      print('Error registering with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign up with Google: $e'),
      ));
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
                'Welcome Back!',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[900],
                ),
              ),
              SizedBox(height: 50),
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: signInWithEmail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red, 
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          minimumSize: Size(300, 40),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
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
              SizedBox(height: 50),
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
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      );
                    },
                    child: Text(
                      "Sign Up",
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

