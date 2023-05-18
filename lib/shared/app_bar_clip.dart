import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyArc extends StatelessWidget {
  final double diameter;
  final Color color;

  const MyArc({
    Key? key,
    this.diameter = 200,
    this.color = AppColors.primaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyArcPainter(color: color),
      size: Size(diameter, diameter),
    );
  }
}

class MyArcPainter extends CustomPainter {
  final Color color;

  MyArcPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.65);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.65,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
