import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Contactscreen extends StatefulWidget {
  const Contactscreen({super.key});

  @override
  State<Contactscreen> createState() => _ContactscreenState();
}

class _ContactscreenState extends State<Contactscreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String responseMessage = "";

  Future<void> uploadContant() async {
    var url = Uri.parse("https://reqres.in/api/users");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": nameController.text,
        "phone": phoneController.text,
      }),
    );
    setState(() => responseMessage = response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Upload Contact")),
      body: Column(
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone"),
          ),
          ElevatedButton(onPressed: uploadContant, child: Text("Upload")),
          Text("Response:$responseMessage"),
        ],
      ),
    );
  }
}
