import 'package:flutter/material.dart';
import 'package:passing_data/cloud_uI.dart';
import 'package:passing_data/post_api_example/addendance.dart';
import 'package:passing_data/post_api_example/addproduct.dart';
import 'package:passing_data/post_api_example/contactScreen.dart';
import 'package:passing_data/post_api_example/feedback.dart';
import 'package:passing_data/post_api_example/registerscreen.dart';
import 'package:passing_data/punch_card.dart';
import 'package:passing_data/punch_card1.dart';
import 'package:passing_data/punch_screen.dart';
import 'package:passing_data/punch_screen1.dart';
import 'package:passing_data/punchbutton.dart';
import 'package:passing_data/signin_page.dart';
import 'package:passing_data/signup_page.dart';
import 'package:passing_data/uploadImage.dart';
import 'attendace_app1.dart';
import 'demo1.dart';
import 'homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Demo1(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'signin_page.dart';
// import 'signup_page.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Professional Auth Pages',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         useMaterial3: true,
//         fontFamily: 'Roboto',
//       ),
//       // Start with Sign In page
//       home: const SignInPage(),
//       // Define routes for navigation
//       routes: {
//         '/signin': (context) => const SignInPage(),
//         '/signup': (context) => const SignUpPage(),
//       },
//     );
//   }
// }
