import 'package:first_01/pages/SingIn.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Medical Cross Icon
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: CustomPaint(
                  // painter: MedicalCrossPainter(),
                  child: Image.asset('assets/pulseCareImg.png')

                ),
              ),

              const SizedBox(height: 40),

              // Welcome Text
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 24),

              // Description Text
              const Text(
                'From checkups to reminders,\nyour personal healthcare companion\nis here.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),

              const Spacer(flex: 2),

              // Get Started Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4ECDC4),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),


              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class MedicalCrossPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Blue gradient colors
    final blueGradient = LinearGradient(
      colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // Green gradient colors
    final greenGradient = LinearGradient(
      colors: [Color(0xFF4ECDC4), Color(0xFF26A69A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final center = Offset(size.width / 2, size.height / 2);
    final crossSize = size.width * 0.7;

    // Create paths for each part of the cross
    final path1 = Path();
    final path2 = Path();
    final path3 = Path();
    final path4 = Path();
    final leafPath = Path();

    // Top part of cross (blue)
    path1.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy - crossSize * 0.25),
        width: crossSize * 0.35,
        height: crossSize * 0.5,
      ),
      const Radius.circular(12),
    ));

    // Right part of cross (blue)
    path2.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx + crossSize * 0.25, center.dy),
        width: crossSize * 0.5,
        height: crossSize * 0.35,
      ),
      const Radius.circular(12),
    ));

    // Bottom part of cross (blue)
    path3.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + crossSize * 0.25),
        width: crossSize * 0.35,
        height: crossSize * 0.5,
      ),
      const Radius.circular(12),
    ));

    // Left part of cross (blue)
    path4.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(center.dx - crossSize * 0.25, center.dy),
        width: crossSize * 0.5,
        height: crossSize * 0.35,
      ),
      const Radius.circular(12),
    ));

    // Green leaf shape in the center-right
    leafPath.moveTo(center.dx - 5, center.dy - 15);
    leafPath.quadraticBezierTo(center.dx + 15, center.dy - 20, center.dx + 25, center.dy - 5);
    leafPath.quadraticBezierTo(center.dx + 20, center.dy + 5, center.dx + 15, center.dy + 15);
    leafPath.quadraticBezierTo(center.dx + 5, center.dy + 10, center.dx - 5, center.dy - 15);

    // Paint blue parts
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