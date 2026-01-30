import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardIdController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  File? _faceImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  void dispose() {
    _cardIdController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _captureImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _faceImage = File(image.path);
        });
      }
    } catch (e) {
      _showSnackBar('Error capturing image: $e', isError: true);
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Color(0xFF6C63FF)),
              title: const Text('Take a Photo'),
              onTap: () {
                Navigator.pop(context);
                _captureImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, color: Color(0xFF6C63FF)),
              title: const Text('Choose from Gallery'),
              onTap: () {
                Navigator.pop(context);
                _captureImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      if (_faceImage == null) {
        _showSnackBar('Please capture your face image', isError: true);
        return;
      }

      setState(() => _isLoading = true);

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() => _isLoading = false);

      _showSnackBar('Account created successfully!');

      // Navigate to next screen or handle success
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),

                  // Company Logo
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C63FF).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.business,
                        size: 60,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Title
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3142),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sign up to get started',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF9E9E9E),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Face Capture Section
                  _buildFaceCaptureSection(),

                  const SizedBox(height: 24),

                  // Card ID Field
                  _buildTextField(
                    controller: _cardIdController,
                    label: 'Card ID',
                    hint: 'Enter your card ID',
                    icon: Icons.credit_card,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your card ID';
                      }
                      if (value.length < 6) {
                        return 'Card ID must be at least 6 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Full Name Field
                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    hint: 'Enter your full name',
                    icon: Icons.person_outline,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Email Field
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Password Field
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    icon: Icons.lock_outline,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF9E9E9E),
                      ),
                      onPressed: () {
                        setState(() => _obscurePassword = !_obscurePassword);
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  // Confirm Password Field
                  _buildTextField(
                    controller: _confirmPasswordController,
                    label: 'Confirm Password',
                    hint: 'Re-enter your password',
                    icon: Icons.lock_outline,
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF9E9E9E),
                      ),
                      onPressed: () {
                        setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 32),

                  // Sign Up Button
                  ElevatedButton(
                    onPressed: _isLoading ? null : _handleSignUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6C63FF),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: _isLoading
                        ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                        : const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Sign In Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Color(0xFF9E9E9E)),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to sign in page
                          // Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFF6C63FF),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFaceCaptureSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        children: [
          if (_faceImage != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    _faceImage!,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _faceImage = null),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C63FF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.face,
                    size: 50,
                    color: Color(0xFF6C63FF),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Capture Your Face',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Required for verification',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _showImageSourceDialog,
            icon: const Icon(Icons.camera_alt),
            label: Text(_faceImage != null ? 'Retake Photo' : 'Capture Face'),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFF6C63FF),
              side: const BorderSide(color: Color(0xFF6C63FF)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2D3142),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(icon, color: const Color(0xFF6C63FF)),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.grey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}