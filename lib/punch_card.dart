import 'package:flutter/material.dart';

class AttendancePunchScreen extends StatelessWidget {
  const AttendancePunchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Punch Log",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        leading: const Icon(Icons.menu, color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🔍 Filter Section
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(child: _dateButton("From Date")),
                  const SizedBox(width: 8),
                  Expanded(child: _dateButton("To Date")),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("Search"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 📄 Single Attendance Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: const [

                  /// Punch In (LEFT)
                  Expanded(
                    child: PunchInfo(
                      title: "Punch In",
                      time: "15:36",
                      date: "17 Jan 2023",
                      location: "Vadodara",
                      color: Colors.green,
                      imageUrl:
                      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
                    ),
                  ),

                  /// Divider (NO GAP)
                  VerticalDivider(
                    thickness: 10,
                    width: 10,
                    color: Colors.black,
                  ),

                  /// Punch Out (RIGHT)
                  Expanded(
                    child: PunchInfo(
                      title: "Punch Out",
                      time: "17:36",
                      date: "17 Jan 2023",
                      location: "Vadodara",
                      color: Colors.red,
                      imageUrl:
                      "https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateButton(String title) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(title),
    );
  }
}

/// 🔹 Punch Info Widget
class PunchInfo extends StatelessWidget {
  final String title;
  final String time;
  final String date;
  final String location;
  final Color color;
  final String imageUrl;

  const PunchInfo({
    super.key,
    required this.title,
    required this.time,
    required this.date,
    required this.location,
    required this.color,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 36,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        Text(time, style: const TextStyle(fontSize: 14)),
        Text(date,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, size: 14, color: Colors.grey),
            const SizedBox(width: 4),
            Text(location, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}
