import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/change_password_controller.dart';
import 'package:navid_app/utils/state_status.dart';
class ChangePasswordPage extends GetView<ChangePasswordController> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController reNewPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        actions: [
          Container(
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: passwordController,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value){
                      if(value.isEmpty){
                        return 'Old password is required';
                      }
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                        labelText: 'Enter old password',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: newPasswordController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value){
                      if(value.isEmpty){
                        return 'New password is required';
                      }
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                        labelText: 'Enter new password',
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    controller: reNewPasswordController,
                    onEditingComplete: () => node.nextFocus(),
                    validator: (value){
                      if(value.isEmpty){
                        return 'password confirmation is required';
                      }
                      else
                      if(value != newPasswordController.text){
                        return 'new password and confirmation does not match';
                      }
                      else return null;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                        labelText: 'Enter new password confirmation',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:Get.theme.brightness == Brightness.light?
                            BorderSide.none:BorderSide(color: Colors.white)

                        ),
                        border:OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide:Get.theme.brightness == Brightness.light?
                            BorderSide.none:BorderSide(color: Colors.white)
                        )
                    ),
                  ),
                ),
                  SizedBox(height: 16.0,),
                  Obx(()=>Row(

                    children: [
                      Expanded(
                        child:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
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
                                  'old_password': passwordController.text,
                                  'password': newPasswordController.text,
                                  'password_confirmation': reNewPasswordController.text,
                                };
                                controller.changePassword(jsonMap,done);
                              }

                            },
                            child:controller.changePasswordState.value == StateStatus.LOADING?
                            Container(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(),
                            ):
                            controller.changePasswordState.value == StateStatus.SUCCESS?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Change Password',style: TextStyle(color: Colors.white),),
                                Icon(Icons.check_sharp)
                              ],
                            ):Text('Change Password',style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  )),
              ],),
            ),
          ),
        ),
      )
    );
  }
  done(bool val){
    passwordController.clear();
    newPasswordController.clear();
    reNewPasswordController.clear();
  }
}
