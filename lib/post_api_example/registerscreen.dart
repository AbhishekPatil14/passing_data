import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final nameController=TextEditingController();
  final jobController=TextEditingController();
  String responseMessage="";
  
  Future<void> registerUser() async{
    var url=Uri.parse("https://reqres.in/api/users");
    var response=await http.post(
      url,
      headers:{"Content-Type":"application/json"},
      body:jsonEncode({"name":nameController.text,"job":jobController.text}),
    );
    setState(() => responseMessage = response.body);
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register Screen")),
      body: Column(
        children: [
          TextField(controller: nameController,decoration: InputDecoration(labelText: "Name")),
          TextField(controller: jobController,decoration: InputDecoration(labelText: "Job")),
          ElevatedButton(onPressed: registerUser, child: Text("Submit")),
          Text("Response:$responseMessage"),
        ],
      ),
    );
  }
}
