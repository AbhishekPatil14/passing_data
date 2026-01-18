import 'package:flutter/material.dart';
import 'package:passing_data/Welcomepage.dart';
import 'package:passing_data/slide_drawer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController _name = new TextEditingController();
  TextEditingController _email = new TextEditingController();
  TextEditingController _phone = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue,),
      drawer: SlideDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter Phone',
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Welcomepage(
                    name: _name.text,
                    email: _email.text,
                    phone: _phone.text,
                  ),
                ),
              );
            },
            child: Text('Go to Welcome'),
          ),
        ],
      ),
    );
  }
}


// Future<List<String>> fetchCategories() async {
//   final url = Uri.parse('$baseUrl/GetCategory');
//
//   final response = await http.get(url);
//
//   if (response.statusCode == 200) {
//     final jsonBody = json.decode(response.body);
//     final List<dynamic> data = jsonBody['Data'];
//
//     return data.map((item) => item['CategoryName'] as String).toList();
//   } else {
//     throw Exception('Failed to load categories:${response.reasonPhrase}');
//   }
// }


// Future<Map<String, dynamic>> addNewContact(
//     AddContactModel addContactModel) async {
//   try {
//     final requestBody = {
//       "companyName": addContactModel.companyName,
//       "contactName": addContactModel.contactName,
//       "phone": addContactModel.phone,
//       "mobile": addContactModel.mobile,
//       "email": addContactModel.email,
//     };
//
//     logGreen(msg: "addContact request body ------> $requestBody");
//
//     final headers = {'Content-Type': 'application/json'};
//
//     final url = Uri.parse('$baseUrl/');
//
//     showLog(msg: "$baseUrl/"); /
//
//     final response = await http.post(
//       url,
//       headers: headers,
//       body: jsonEncode(requestBody),
//     );
//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       logRed(msg: "add contact error ---> ${response.body}");
//       throw Exception('Failed to addContact ${response.statusCode}');
//     }
//   } catch (e) {
//     logRed(msg: "add contact error ---> $e");
//     throw Exception('Failed to addContact $e');
//   }
// }

// import 'dart:developer';
//
// void showLog({required String msg}) {
//   // log('\x1B[35m$msg\x1B[0m');
// }
//
// void logRed({required String msg}) {
//   // log('\x1B[31m$msg\x1B[0m');
// }
//
// void logGreen({required String msg}) {
//   // log('\x1B[32m$msg\x1B[0m');
// }
//
// void logBlue({required String msg}) {
//   // log('\x1B[34m$msg\x1B[0m');
// }