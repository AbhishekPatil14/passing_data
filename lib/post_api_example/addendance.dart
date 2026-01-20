import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String responseMessage = "";

  Future<void> markAttendance() async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"student": "Abhishek", "status": "Present"}),
    );
    setState(() => responseMessage = response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Attendance")),
      body: Column(
        children: [
          ElevatedButton(onPressed: markAttendance, child: Text("Mark Present")),
          Text("Response: $responseMessage"),
        ],
      ),
    );
  }
}
