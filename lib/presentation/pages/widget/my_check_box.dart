import 'package:flutter/material.dart';
import 'package:get/get.dart';
class MyCheckBox extends StatefulWidget {
  Color checkedColor = Get.theme.primaryColor;
  Color unCheckedColor = Colors.transparent;
  Color color = Get.theme.scaffoldBackgroundColor;
  Color borderColor = Colors.grey;
  double borderWidth = 3.0;
  bool check = false;
  MyCheckBox({this.check,this.color,this.checkedColor,this.unCheckedColor,this.borderColor,this.borderWidth});
  @override
  _MyCheckBoxState createState() => _MyCheckBoxState();
}

class _MyCheckBoxState extends State<MyCheckBox> with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  Animation _colorTween;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _colorTween = ColorTween(begin: widget.color, end: Colors.transparent)
        .animate(_animationController);

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if (widget.check) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    return Container(
      decoration: new BoxDecoration(
        border: Border.all(color: widget.borderColor,width: widget.borderWidth),
        color:_colorTween.value,
        shape: BoxShape.circle,
      ),
      child: widget.check?Icon(Icons.check_sharp,color: widget.checkedColor,):Container(),
    );
  }
}
