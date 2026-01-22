import 'package:flutter/material.dart';

class PunchStackScreen extends StatelessWidget {
  const PunchStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: const Text("Punch Records"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            PunchRowCard(
              type: "PunchIn",
              time: "15:36",
              date: "17-03-2026",
              location: "Vadodara",
              imageUrl:
              "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
              type1: "PunchIn",
              time1: "15:36",
              date1: "17-03-2026",
              location1: "Vadodara",
              imageUrl1:
              "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
            ),
          ],
        ),
      ),
    );
  }
}

class PunchRowCard extends StatelessWidget {
  final String type;
  final String time;
  final String date;
  final String location;
  final String imageUrl;

  final String type1;
  final String time1;
  final String date1;
  final String location1;
  final String imageUrl1;

  const PunchRowCard({
    super.key,
    required this.type,
    required this.time,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.type1,
    required this.time1,
    required this.date1,
    required this.location1,
    required this.imageUrl1,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _punchRow(type, time, date, location, imageUrl),
            const Divider(height: 24),
            _punchRow(type1, time1, date1, location1, imageUrl1),
          ],
        ),
      ),
    );
  }

  Widget _punchRow(
      String type,
      String time,
      String date,
      String location,
      String imageUrl,
      ) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("Time: $time"),
              Text("Date: $date"),
              Text(
                location,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

