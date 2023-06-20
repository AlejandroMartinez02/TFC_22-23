import 'package:flutter/material.dart';

class ProductBackground extends StatelessWidget {
  const ProductBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height * 0.4,
        child: CustomPaint(painter: _CurvePainter(primaryColor)));
  }
}

class _CurvePainter extends CustomPainter {
  final Color primaryColor;

  _CurvePainter(this.primaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final pen = Paint();

    pen.color = Colors.white;
    pen.style = PaintingStyle.fill;
    pen.strokeWidth = 20;

    final path = Path();

    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.55,
      size.width * 0.25,
      size.height * 0.5,
    );
    path.lineTo(size.width, size.width);

    canvas.drawPath(path, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
