import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
class SettingsPage extends GetView<SettingController> {
  bool isDarkModeEnabled=true ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),
        actions: [
          Container(
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
      body:
      Obx(()=>SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: 
                BoxDecoration(
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.blueGrey.shade100,
                    //     spreadRadius: 1,
                    //     blurRadius:5,
                    //     // Get.theme.brightness == Brightness.light? 15:5,
                    //     offset: Offset(0, 1), // changes position of shadow
                    //   ),
                    // ],
                    color: controller.darkMode.value?Colors.white24:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                ),
                
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Font Size"),
                        Text(controller.fontSize.toInt().toString()),
                      ],
                    ),
                    FlutterSlider(
                      values: [controller.fontSize.value],
                      max: 20,
                      min: 10,
                      onDragging: (handlerIndex, lowerValue, upperValue) {
                        controller.changeFontSize(lowerValue);
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 2,
              ),
              InkWell(
                onTap: ()=>controller.setMode(!controller.darkMode.value),
                child: Container(
                  height: 60,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.blueGrey.shade100,
                      //     spreadRadius: 0,
                      //     blurRadius:0,
                      //     // Get.theme.brightness == Brightness.light? 15:5,
                      //     offset: Offset(0, 1), // changes position of shadow
                      //   ),
                      // ],
                      color: controller.darkMode.value?Colors.white24:Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Night Mode"),
                      Text(controller.toggle.value)
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ))
    );
  }
}
