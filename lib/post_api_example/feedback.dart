import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final feedbackController = TextEditingController();
  String responseMessage = "";

  Future<void> sendFeedback() async {
    var url = Uri.parse("https://httpbin.org/post");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"feedback": feedbackController.text, "rating": 5}),
    );
    setState(() => responseMessage = response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Send Feedback")),
      body: Column(
        children: [
          TextField(controller: feedbackController, decoration: InputDecoration(labelText: "Feedback")),
          ElevatedButton(onPressed: sendFeedback, child: Text("Send")),
          Text("Response: $responseMessage"),
        ],
      ),
    );
  }
}
