import 'package:flutter/material.dart';

class Demo1 extends StatelessWidget {
  const Demo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Punch Demo")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Punch Button Look
            PunchButton(
              isPunchedIn: true, // change to true for "Punch Out" look
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => SuccessDialog(isPunchedIn: true),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// Punch Button Look
class PunchButton extends StatelessWidget {
  final bool isPunchedIn;
  final VoidCallback onTap;

  const PunchButton({
    super.key,
    required this.isPunchedIn,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPunchedIn
              ? [const Color(0xFFF5576c), const Color(0xFFF093fb)]
              : [const Color(0xFF667eea), const Color(0xFF764ba2)],
        ),
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: isPunchedIn
                ? const Color(0xFFF5576c).withOpacity(0.5)
                : const Color(0xFF667eea).withOpacity(0.5),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(35),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPunchedIn ? Icons.logout_rounded : Icons.login_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  isPunchedIn ? 'PUNCH OUT' : 'PUNCH IN',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Success Dialog Look
class SuccessDialog extends StatelessWidget {
  final bool isPunchedIn;

  const SuccessDialog({super.key, required this.isPunchedIn});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isPunchedIn
                ? [const Color(0xFF667eea), const Color(0xFF764ba2)]
                : [const Color(0xFFf093fb), const Color(0xFFF5576c)],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPunchedIn ? Icons.check_circle : Icons.exit_to_app,
                size: 48,
                color: isPunchedIn
                    ? const Color(0xFF667eea)
                    : const Color(0xFFF5576c),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isPunchedIn ? 'Punched In!' : 'Punched Out!',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              isPunchedIn ? 'Have a productive day!' : 'Great work today!',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: isPunchedIn
                    ? const Color(0xFF667eea)
                    : const Color(0xFFF5576c),
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
