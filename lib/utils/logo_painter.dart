import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Get.theme.primaryColor;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height/8);
    path.cubicTo(size.width / 4, -size.height / 12, 3 * size.width / 4, size.height / 3, size.width, size.height/10);
    // path.moveTo(0, size.height/5);
    // path.quadraticBezierTo(0, size.height/10, size.width/5, size.height/5);
    // path.quadraticBezierTo(size.width/2, size.height/10, size.width, size.height/5);
    path.lineTo(size.width, size.height/5);
    path.lineTo(size.width, 0);
    // path.cubicTo(size.width / 4, 3 * size.height / 4, 3 * size.width / 4, size.height / 4, size.width, size.height);
    canvas.drawPath(path, paint);
    var path2 = Path();
    Paint paint2 = Paint();
    // path2.moveTo(0, 0);
    paint2.color = Get.theme.primaryColor.withAlpha(90);
    path2.moveTo(0, size.height/8);
    path2.cubicTo(size.width / 4, -size.height / 13, 3 * size.width / 4, 1.1*size.height / 3, size.width, size.height/10);
    // path2.lineTo(size.width, size.height/4);
    path2.cubicTo(3*size.width / 4, size.height / 3, size.width / 4, -size.height / 12, 0, size.height/8);
    // path2.cubicTo(3*size.width / 4, size.height / 3, size.width / 4, size.height / 20, 0, size.height/7);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}