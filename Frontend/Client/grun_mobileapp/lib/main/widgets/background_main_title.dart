import 'package:flutter/material.dart';

class BackgroundMainTitle extends StatelessWidget {
  const BackgroundMainTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: CustomPaint(painter: _CurvePainter(primaryColor)));
  }
}

class _CurvePainter extends CustomPainter {
  final Color primaryColor;

  _CurvePainter(this.primaryColor);

  @override
  void paint(Canvas canvas, Size size) {
    final pen = Paint();

    pen.color = primaryColor;
    pen.style = PaintingStyle.fill;
    pen.strokeWidth = 20;

    final path = Path();

    path.lineTo(0, size.height * 0.17);
    path.quadraticBezierTo(size.width * 0.17, size.height * 0.22,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.67, size.height * 0.12, size.width, size.height * 0.17);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, pen);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
