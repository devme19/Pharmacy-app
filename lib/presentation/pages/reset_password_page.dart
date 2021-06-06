import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/reset_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:navid_app/utils/logo_painter.dart';
class ResetPasswordPage extends GetView<ResetPasswordController>{
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // locale = Locale('en', 'US');
    // Get.updateLocale(locale);
    final node = FocusScope.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Forget Password"),
          actions: [
            Container(

                margin: EdgeInsets.all(8.0),
                // color: Colors.blue.withOpacity(0.1),
                child: Image.asset('asset/images/nhs.png'))
          ],
        ),
        body:Form(
          key: _formKey,
          child:
          Container(
            margin: EdgeInsets.only(left: 32,right: 32),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.shade100,
                                spreadRadius: 2,
                                blurRadius:1,
                                // Get.theme.brightness == Brightness.light? 15:5,
                                offset: Offset(0, 1), // changes position of shadow
                              )
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                        ),
                        margin: EdgeInsets.all(32.0),
                        child: Image.asset('asset/images/logo1.png')),
                    TextFormField(
                      controller: emailController,
                      onEditingComplete: () => node.nextFocus(),
                      // style: TextStyle(fontSize: 25),
                      validator: (value){
                        if(value.isEmpty){
                          return 'email is required'.tr;
                        }
                        else if(GetUtils.isEmail(value))
                          return null;
                        else return 'Invalid email address'.tr;
                      },
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                          labelText: 'Email',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                              borderSide:Get.theme.brightness == Brightness.light?
                              BorderSide.none:BorderSide(color: Colors.white)

                          ),
                          border:OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                              borderSide:Get.theme.brightness == Brightness.light?
                              BorderSide.none:BorderSide(color: Colors.white)
                          )
                      ),
                    ),
                    SizedBox(height: 50,),
                    Row(
                      children: [
                        Expanded(
                          child:
                          RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                // side: BorderSide(color: Colors.grey.shade200)
                              ),
                              // color: Colors.green,
                              padding: EdgeInsets.only(top: 20,bottom: 20),
                              onPressed:() {
                                if (_formKey.currentState.validate()) {
                                  // Get.snackbar('processingDataTxt'.tr, '');
                                  Map<String, dynamic> jsonMap = {
                                    'email': emailController.text,
                                  };
                                  controller.resetPassword(jsonMap);
                                }
                              },
                              child: Text('Reset'.tr,style: TextStyle(color: Colors.white),)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        // CustomPaint(
        //     painter: LogoPainter(),
        //     child:
        //
        // )
    );
  }

}