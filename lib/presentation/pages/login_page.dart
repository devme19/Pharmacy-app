import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/domain/usecases/user/login_use_case.dart';
import 'package:navid_app/presentation/controllers/identity_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/utils/logo_painter.dart';
import 'package:navid_app/utils/state_status.dart';
// ignore: must_be_immutable
class LoginPage extends StatelessWidget{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  IdentityController controller  = Get.put(IdentityController());
  @override
  Widget build(BuildContext context) {
    // locale = Locale('en', 'US');
    // Get.updateLocale(locale);
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        actions: [
            Container(
                margin: EdgeInsets.all(8.0),
                // color: Colors.blue.withOpacity(0.1),
                child: Image.asset('asset/images/nhs.png'))
          ],
        ),
        body:
        Obx(()=>
            Form(
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
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
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
                              prefixIcon: Icon(Icons.email),
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
                        SizedBox(height: 25,),
                        TextFormField(
                          // style: TextStyle(fontSize: 25),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () => node.nextFocus(),
                          controller: passwordController,
                          obscureText: controller.obscureText.value,
                          validator: (value){
                            if(value.isEmpty){
                              return 'password is required'.tr;
                            }
                            else
                              return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.vpn_key),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: (){
                                  controller.obscurePassword();
                                },
                              ),
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
                              Container(
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(borderRadius),
                                      // side: BorderSide(color: Colors.grey.shade200)
                                    ),
                                    // color: Colors.green,
                                    padding: EdgeInsets.only(top: 20,bottom: 20),
                                    onPressed:controller.loginState.value == StateStatus.LOADING?null:() {
                                      if (_formKey.currentState.validate()) {
                                        // Get.snackbar('processingDataTxt'.tr, '');
                                        Map<String, dynamic> jsonMap = {
                                          'email': emailController.text,
                                          'password': passwordController.text,
                                        };
                                        controller.login(jsonMap);
                                      }
                                    },
                                    child:
                                    controller.loginState.value == StateStatus.LOADING ?
                                    Container(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(),
                                    ):
                                    Text('Login')
                                    // Text('Login'.tr,style: TextStyle(color: Colors.white),)
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 25,),
                        Row(
                          children: [
                            Expanded(
                              flex:1,
                              child:
                              Container(
                                height: 50,
                                child: InkWell(
                                  // color: Colors.white,
                                    onTap: (){
                                      Get.toNamed(NavidAppRoutes.registerPage);
                                    },
                                    child: Center(child: Text('Register'.tr))
                                ),
                              ),
                            ),
                            Expanded(
                              flex:1,
                              child:
                              Container(
                                height: 50,
                                child: InkWell(
                                  // color: Colors.white,
                                    onTap: (){
                                      Get.toNamed(NavidAppRoutes.resetPasswordPage);
                                    },
                                    child: Center(child: Padding(
                                      padding: const EdgeInsets.only(right:8.0,left: 8.0),
                                      child: AutoSizeText('Forgot Password?'.tr,maxLines: 1,),
                                    ))
                                ),
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
        //   painter: LogoPainter(),
        //   child:
        //
        // )

        )
    );
  }

}
