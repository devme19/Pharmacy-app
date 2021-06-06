import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';

class DetailOrderPainter extends CustomPainter {
  Color color;
  String title;
  DetailOrderPainter({this.color,this.title});
  SettingController settingController = Get.put(SettingController());
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color.withAlpha(900);
    var path = Path();
    path.lineTo(0, size.height/8);
    path.quadraticBezierTo(size.width/2, size.height/50, size.width, size.height/8);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);

    Paint _paint = Paint()
      ..color = color
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;

    Paint paint3 = Paint()
      ..color = Get.theme.scaffoldBackgroundColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final textSpan = TextSpan(
        text: title,
        style: TextStyle(fontSize: settingController.fontSize.value)
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    canvas.drawOval(Rect.fromPoints(Offset(size.width/2-textPainter.width/2-10,size.height/40), Offset(size.width/2+textPainter.width/2+10,size.height/40+100)), _paint);
    canvas.drawArc(Rect.fromPoints(Offset(size.width/2-textPainter.width/2-10,size.height/40), Offset(size.width/2+textPainter.width/2+10,size.height/40+100)),0, -2*math.pi,false,paint3);


    final offset = Offset(size.width/2-textPainter.width/2, (size.height/40+100)/2);
    textPainter.paint(canvas, offset);


    // Paint paint2 = Paint();
    // paint.color = Colors.red;
    // var path2 = Path();
    // path2.lineTo(0, size.height/8);
    // path2.quadraticBezierTo(size.width/2, size.height/40, size.width, size.height/8);
    // path2.lineTo(size.width, 0);
    // canvas.drawPath(path2, paint2);

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}