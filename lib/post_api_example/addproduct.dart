import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  String responseMessage = "";

  Future<void> addProduct() async {
    var url = Uri.parse("https://dummyjson.com/products/add");
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": titleController.text, "price": int.parse(priceController.text)}),
    );
    setState(() => responseMessage = response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Column(
        children: [
          TextField(controller: titleController, decoration: InputDecoration(labelText: "Title")),
          TextField(controller: priceController, decoration: InputDecoration(labelText: "Price")),
          ElevatedButton(onPressed: addProduct, child: Text("Add")),
          Text("Response: $responseMessage"),
        ],
      ),
    );
  }
}

