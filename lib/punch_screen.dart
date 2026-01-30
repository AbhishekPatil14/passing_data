import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PunchScreen extends StatefulWidget {
  const PunchScreen({Key? key}) : super(key: key);

  @override
  State<PunchScreen> createState() => _PunchScreenState();
}

class _PunchScreenState extends State<PunchScreen> {
  bool isPunchedIn = false;
  DateTime? punchInTime;
  DateTime? punchOutTime;

  // User data
  final String userName = "John Smith";
  final String userEmail = "john.smith@company.com";
  final String cardId = "EMP-2024-1234";
  final String office = "Main Office - Building A";

  void _handlePunch() {
    setState(() {
      if (!isPunchedIn) {
        punchInTime = DateTime.now();
        isPunchedIn = true;
        _showSnackBar("Punched In Successfully!", Colors.green);
      } else {
        punchOutTime = DateTime.now();
        isPunchedIn = false;
        _showSnackBar("Punched Out Successfully!", Colors.orange);
        // Reset after 2 seconds for demo
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            setState(() {
              punchInTime = null;
              punchOutTime = null;
            });
          }
        });
      }
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Attendance',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Gradient
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isPunchedIn
                      ? [Colors.orange[400]!, Colors.deepOrange[600]!]
                      : [Colors.blue[400]!, Colors.blue[700]!],
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Logo Icon
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        isPunchedIn ? Icons.logout : Icons.login,
                        size: 60,
                        color: isPunchedIn ? Colors.orange[700] : Colors.blue[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Title
                    Text(
                      isPunchedIn ? 'PUNCH OUT' : 'PUNCH IN',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isPunchedIn
                          ? 'Ready to end your shift?'
                          : 'Ready to start your shift?',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // User Information Card
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Employee Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Name Field
                      _buildInfoRow(
                        icon: Icons.person,
                        label: 'Name',
                        value: userName,
                        iconColor: Colors.blue,
                      ),
                      const Divider(height: 24),

                      // Email Field
                      _buildInfoRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: userEmail,
                        iconColor: Colors.green,
                      ),
                      const Divider(height: 24),

                      // Card ID Field
                      _buildInfoRow(
                        icon: Icons.badge,
                        label: 'Card ID',
                        value: cardId,
                        iconColor: Colors.purple,
                      ),
                      const Divider(height: 24),

                      // Office Field
                      _buildInfoRow(
                        icon: Icons.business,
                        label: 'Office',
                        value: office,
                        iconColor: Colors.orange,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Time Information (if punched in)
            if (punchInTime != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Card(
                  elevation: 2,
                  color: Colors.blue[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.blue[700], size: 30),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Punch In Time',
                                style: TextStyle(
                                  color: Colors.blue[900],
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('hh:mm:ss a').format(punchInTime!),
                                style: TextStyle(
                                  color: Colors.blue[700],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 30),

            // Punch Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: _handlePunch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPunchedIn ? Colors.orange[600] : Colors.blue[600],
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        isPunchedIn ? Icons.logout : Icons.login,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        isPunchedIn ? 'PUNCH OUT NOW' : 'PUNCH IN NOW',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Current Date/Time Display
            Text(
              DateFormat('EEEE, MMMM dd, yyyy').format(DateTime.now()),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}