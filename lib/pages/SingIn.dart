import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PulseCare',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await http.post(
          Uri.parse('http://192.168.8.170:8080/customer/login'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'username': _usernameController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'])),
          );
          // Navigate to home screen or save token if authentication is successful
          // Example: Navigator.pushReplacementNamed(context, '/home');
        } else {
          final errorData = jsonDecode(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${errorData['message']}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connection error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[100]!,
              Color(0xFF4ECDC4),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header with logo and branding
                    Column(
                      children: [
                        // Logo
                        Container(
                          width: 80,
                          height: 80,
                          child: CustomPaint(
                            painter: MedicalCrossPainter(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'PulseCare',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                        const Text(
                          'Care in Your Pocket',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF2196F3),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 50),

                    // Sign in form card
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF4ECDC4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Sign In title
                              const Center(
                                child: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Username field
                              const Text(
                                'Username :',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Username',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a username';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),

                              // Password field
                              const Text(
                                'Password :',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Password',
                                  hintStyle: TextStyle(color: Colors.grey[400]),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey[400],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isPasswordVisible = !_isPasswordVisible;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 12),

                              // Forgot Password
                              Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () => print('Forgot Password pressed'),
                                  child: const Text(
                                    'Forget Password ?',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF2196F3),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Sign In button
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: ElevatedButton(
                                  onPressed: loginUser,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF4ECDC4),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(26),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Or Sign In With
                              const Center(
                                child: Text(
                                  'Or Sign In With',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Social login buttons
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildSocialButton(
                                    icon: Icons.facebook,
                                    color: const Color(0xFF1877F2),
                                    onTap: () => print('Facebook login'),
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSocialButton(
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF4285F4),
                                            Color(0xFF34A853),
                                            Color(0xFFFBBC05),
                                            Color(0xFFEA4335),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'G',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () => print('Google login'),
                                  ),
                                  const SizedBox(width: 16),
                                  _buildSocialButton(
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'X',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () => print('X login'),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 30),

                              // Don't have account
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Don\'t Have an Account ? ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => print('Sign Up pressed'),
                                      child: const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF2196F3),
                                          fontWeight: FontWeight.w600,
                                        ),
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    IconData? icon,
    Widget? child,
    required VoidCallback onTap,
    Color? color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: child ?? Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class MedicalCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final blueGradient = LinearGradient(
      colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final greenGradient = LinearGradient(
      colors: [Color(0xFF4ECDC4), Color(0xFF26A69A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final crossSize = size.width * 0.7;

    // Create cross paths
    final path1 = Path();
    final path2 = Path();
    final path3 = Path();
    final path4 = Path();
    final leafPath = Path();

    // Cross parts
    path1.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - crossSize * 0.25),
        width: crossSize * 0.35,
        height: crossSize * 0.5,
      ),
      const Radius.circular(8),
    ));

    path2.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx + crossSize * 0.25, center.dy),
        width: crossSize * 0.5,
        height: crossSize * 0.35,
      ),
      const Radius.circular(8),
    ));

    path3.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + crossSize * 0.25),
        width: crossSize * 0.35,
        height: crossSize * 0.5,
      ),
      const Radius.circular(8),
    ));

    path4.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx - crossSize * 0.25, center.dy),
        width: crossSize * 0.5,
        height: crossSize * 0.35,
      ),
      const Radius.circular(8),
    ));

    // Leaf shape
    leafPath.moveTo(center.dx - 3, center.dy - 10);
    leafPath.quadraticBezierTo(center.dx + 10, center.dy - 15, center.dx + 18, center.dy - 3);
    leafPath.quadraticBezierTo(center.dx + 15, center.dy + 3, center.dx + 10, center.dy + 10);
    leafPath.quadraticBezierTo(center.dx + 3, center.dy + 7, center.dx - 3, center.dy - 10);

    // Paint blue cross
    paint.shader = blueGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
    canvas.drawPath(path3, paint);
    canvas.drawPath(path4, paint);

    // Paint green leaf
    paint.shader = greenGradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.drawPath(leafPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}