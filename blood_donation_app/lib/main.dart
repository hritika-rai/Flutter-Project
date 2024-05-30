import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './screens/Login.dart';
import 'firebase_options.dart';
import './screens/SignUp.dart';
import 'screens/IntroScreen.dart';


// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
  
//   // Check if Firebase apps are already initialized
//   if (Firebase.apps.isEmpty) {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }
  
//   runApp(const MyApp());
// }

// void main() async {
//   runApp(const MyApp());
// }

// Future<void> initializeFirebase() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFirebase();
  runApp(
    const ProviderScope(child: 
      MyApp(),
    ),
  );
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

// void main() {
//   runApp(
//     const ProviderScope(
//       child: MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   useMaterial3: true,
      //   primarySwatch: Colors.red,
      //   cardColor: Colors.white,
      // ),
      home:  IntroScreen(),
    );
  }
}



