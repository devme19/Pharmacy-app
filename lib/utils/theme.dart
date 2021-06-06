import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';

class Themes{
  static SettingController settingController = Get.put(SettingController());
  final light = ThemeData.light().copyWith(
    // backgroundColor: Colors.white,
    // buttonColor: Colors.blue,
    // buttonColor: Colors.green,
    scaffoldBackgroundColor: Color(0xffeeeeee),
    primaryColor: Color(0xff005DB8),
    // accentColor: Colors.white,
    accentColor: Colors.black87,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.green,
      textTheme: ButtonTextTheme.primary

    ),
    // primaryColor: Color.fromRGBO(67, 103, 203,1),
    // primaryColor: Colors.green,

    textTheme: TextTheme(

      // body2: TextStyle(
      //     fontSize: settingController.fontSize.value
      // ),
      // subhead: TextStyle(fontSize: settingController.fontSize.value),
      // body1: TextStyle(
      //     fontSize: settingController.fontSize.value
      // ),

      bodyText2: TextStyle(
          fontSize: settingController.fontSize.value,
          color: Colors.black87

      ),
      bodyText1: TextStyle(
          fontSize: settingController.fontSize.value,
          color: Colors.black87
      ),
      subtitle1: TextStyle(
          fontSize: settingController.fontSize.value,
          color: Colors.black87
      ),
      button: TextStyle(
          fontSize: settingController.fontSize.value,
          // color: Colors.black54
      ),
    ),
  );
  final dark = ThemeData.dark().copyWith(
    // backgroundColor: Colors.red,
    // buttonColor: Colors.red,
    // cardColor: Colors.white10

    scaffoldBackgroundColor: Color(0xff353839),
      primaryColor: Colors.red.shade900,
    // accentColor: Colors.white,
    accentColor: Colors.white,
    buttonTheme: ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary
    ),
    // primaryColor: Color.fromRGBO(67, 103, 203,1),
    // primaryColor: Colors.green,

    textTheme: TextTheme(

      // body2: TextStyle(
      //     fontSize: settingController.fontSize.value
      // ),
      // subhead: TextStyle(fontSize: settingController.fontSize.value),
      // body1: TextStyle(
      //     fontSize: settingController.fontSize.value
      // ),
      bodyText2: TextStyle(
          fontSize: settingController.fontSize.value,
          // color: Colors.black87

      ),
      bodyText1: TextStyle(
          fontSize: settingController.fontSize.value,
          // color: Colors.black87
      ),
      subtitle1: TextStyle(
          fontSize: settingController.fontSize.value,
          // color: Colors.black87
      ),
      button: TextStyle(
        fontSize: settingController.fontSize.value,
        // color: Colors.black54
      ),
    ),
  );
  ThemeMode get theme => settingController.darkMode.value ? ThemeMode.dark : ThemeMode.light;
}