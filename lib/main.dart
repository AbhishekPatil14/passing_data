import 'package:flutter/material.dart';
import 'package:passing_data/post_api_example/addendance.dart';
import 'package:passing_data/post_api_example/addproduct.dart';
import 'package:passing_data/post_api_example/contactScreen.dart';
import 'package:passing_data/post_api_example/feedback.dart';
import 'package:passing_data/post_api_example/registerscreen.dart';
import 'package:passing_data/punchbutton.dart';
import 'package:passing_data/uploadImage.dart';
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
      home: Contactscreen(),
    );
  }
}
