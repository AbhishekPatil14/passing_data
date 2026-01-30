import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ProfessionalPunchScreen extends StatefulWidget {
  const ProfessionalPunchScreen({Key? key}) : super(key: key);

  @override
  State<ProfessionalPunchScreen> createState() => _ProfessionalPunchScreenState();
}

class _ProfessionalPunchScreenState extends State<ProfessionalPunchScreen>
    with TickerProviderStateMixin {
  bool isPunchedIn = false;
  DateTime? punchInTime;
  DateTime? punchOutTime;
  String currentTime = '';
  Timer? _timer;

  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  // User data - Replace with actual data
  final String userName = "John Smith";
  final String userEmail = "john.smith@company.com";
  final String cardId = "EMP-2024-1234";
  final String office = "Main Office - Building A";

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeOutBack),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _scaleController.forward();
    _slideController.forward();
  }

  void _updateTime() {
    setState(() {
      currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _handlePunch() async {
    setState(() {
      if (!isPunchedIn) {
        punchInTime = DateTime.now();
        isPunchedIn = true;
      } else {
        punchOutTime = DateTime.now();
        isPunchedIn = false;
      }
    });

    // Animate the transition
    _scaleController.reset();
    _fadeController.reset();
    await Future.delayed(const Duration(milliseconds: 100));
    _scaleController.forward();
    _fadeController.forward();

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ScaleTransition(
        scale: _scaleAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
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
                  isPunchedIn
                      ? 'Have a productive day!'
                      : 'Great work today!',
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isPunchedIn
                ? [
              const Color(0xFFF5F7FA),
              const Color(0xFFE8EAF6),
            ]
                : [
              const Color(0xFFFFF8F3),
              const Color(0xFFFCE4EC),
            ],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            _buildStatusCard(),
                            const SizedBox(height: 24),
                            _buildEmployeeCard(),
                            const SizedBox(height: 24),
                            if (punchInTime != null) _buildTimeTracker(),
                            const SizedBox(height: 32),
                            _buildPunchButton(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attendance',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: isPunchedIn
                          ? const Color(0xFF1A237E)
                          : const Color(0xFF880E4F),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEEE, MMMM dd').format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isPunchedIn
                      ? const Color(0xFF667eea).withOpacity(0.1)
                      : const Color(0xFFF5576c).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isPunchedIn
                        ? const Color(0xFF667eea).withOpacity(0.3)
                        : const Color(0xFFF5576c).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Text(
                  currentTime,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isPunchedIn
                        ? const Color(0xFF667eea)
                        : const Color(0xFFF5576c),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isPunchedIn
                ? [const Color(0xFF667eea), const Color(0xFF764ba2)]
                : [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: isPunchedIn
                  ? const Color(0xFF667eea).withOpacity(0.4)
                  : const Color(0xFF4facfe).withOpacity(0.4),
              blurRadius: 30,
              offset: const Offset(0, 15),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPunchedIn ? Icons.work : Icons.login_rounded,
                size: 64,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              isPunchedIn ? 'Currently Working' : 'Ready to Start',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isPunchedIn
                  ? 'You are clocked in'
                  : 'Punch in to begin your shift',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isPunchedIn
                        ? [const Color(0xFF667eea), const Color(0xFF764ba2)]
                        : [const Color(0xFF4facfe), const Color(0xFF00f2fe)],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    userName.split(' ').map((e) => e[0]).take(2).join(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isPunchedIn
                          ? const Color(0xFF667eea)
                          : const Color(0xFF4facfe),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Employee Profile',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D3748),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Divider(height: 1),
          const SizedBox(height: 24),
          _buildInfoTile(
            icon: Icons.email_outlined,
            label: 'Email Address',
            value: userEmail,
            color: const Color(0xFF4facfe),
          ),
          const SizedBox(height: 16),
          _buildInfoTile(
            icon: Icons.badge_outlined,
            label: 'Employee ID',
            value: cardId,
            color: const Color(0xFF667eea),
          ),
          const SizedBox(height: 16),
          _buildInfoTile(
            icon: Icons.business_outlined,
            label: 'Office Location',
            value: office,
            color: const Color(0xFFF5576c),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: color,
            size: 22,
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
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF2D3748),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeTracker() {
    final duration = DateTime.now().difference(punchInTime!);
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667eea).withOpacity(0.1),
            const Color(0xFF764ba2).withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF667eea).withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_outlined,
                color: const Color(0xFF667eea),
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Time Elapsed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF667eea),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeUnit(hours, 'HRS'),
              const Text(
                ' : ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF667eea),
                ),
              ),
              _buildTimeUnit(minutes, 'MIN'),
              const Text(
                ' : ',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF667eea),
                ),
              ),
              _buildTimeUnit(seconds, 'SEC'),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 8),
                Text(
                  'Started at ${DateFormat('hh:mm a').format(punchInTime!)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF667eea).withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF667eea),
              height: 1,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.grey[600],
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildPunchButton() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
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
              spreadRadius: 0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _handlePunch,
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
      ),
    );
  }
}