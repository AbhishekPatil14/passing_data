import 'package:flutter/material.dart';

class Welcomepage extends StatelessWidget {

  String name,email,phone;
  Welcomepage({required this.name,required this.email,required this.phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text('Name: ${name}')),
          Text('Email:${email}'),
          Text('Phone:${phone}')
        ],
      ),
    );
  }
}
