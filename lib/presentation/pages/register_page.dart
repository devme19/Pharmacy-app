import 'dart:convert';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/register_controller.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/utils/logo_painter.dart';
import 'package:navid_app/utils/state_status.dart';

// ignore: must_be_immutable
class RegisterPage extends GetView<RegisterController>{
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();
  // FocusNode firstNameFocus,lastNameFocus,emailFocus,passwordFocus,retypePasswordFocus;
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus= FocusNode();
  FocusNode emailFocus= FocusNode();
  FocusNode passwordFocus= FocusNode();
  FocusNode retypePasswordFocus= FocusNode();
  final _formKey = GlobalKey<FormState>();
  RegisterPage(){
    // firstNameController.text = 'mehdi';
    // lastNameController.text = 'Alishah';
    // emailController.text = 'mahmoud.alishah19@gmail.com';
    // passwordController.text = '123456789';
    // retypePasswordController.text = '123456789';
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
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
                // margin: EdgeInsets.all(64),
                padding: EdgeInsets.all(32),
                child:
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          textInputAction: TextInputAction.next,
                          controller: firstNameController,
                          focusNode: firstNameFocus,
                          validator: (value){
                            if(value.isEmpty){
                              return 'first name is required'.tr;
                            }
                            else return null;
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(lastNameFocus);
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                              labelText: 'First Name',
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
                          textInputAction: TextInputAction.next,
                          controller: lastNameController,
                          focusNode: lastNameFocus,
                          validator: (value){
                            if(value.isEmpty){
                              return 'Surname is required'.tr;
                            }
                            else return null;
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(emailFocus);
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                              labelText: 'Surname',
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
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          focusNode: emailFocus,
                          validator: (value){
                            if(value.isEmpty){
                              return 'email is required'.tr;
                            }
                            else if(GetUtils.isEmail(value.replaceAll(new RegExp(r"\s+"), "")))
                              return null;
                            else return 'Invalid email address'.tr;
                          },
                          onEditingComplete: () {
                            FocusScope.of(context).requestFocus(passwordFocus);
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
                        SizedBox(height: 25,),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          focusNode: passwordFocus,
                          controller: passwordController,
                          obscureText: controller.obscureTextPassword.value,
                          validator: (value){
                            if(value.isEmpty){
                              return 'password is required'.tr;
                            }
                            else
                            if(value.length<8){
                              return 'the password must be at least 8 characters'.tr;
                            }
                            return null;
                          },
                          onEditingComplete: (){
                            FocusScope.of(context).requestFocus(retypePasswordFocus);
                          },

                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                              labelText: 'Password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  borderSide:Get.theme.brightness == Brightness.light?
                                  BorderSide.none:BorderSide(color: Colors.white)

                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: (){
                                  controller.obscurePassword();
                                },
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
                          textInputAction: TextInputAction.done,
                          focusNode: retypePasswordFocus,
                          controller: retypePasswordController,
                          obscureText: controller.obscureTextRePassword.value,
                          validator: (value){
                            if(value.isEmpty){
                              return 'confirm password is required'.tr;
                            }
                            else
                            if(value!=passwordController.text){
                              return 'the password and confirmation does not match'.tr;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                              labelText: 'Confirm Password',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  borderSide:Get.theme.brightness == Brightness.light?
                                  BorderSide.none:BorderSide(color: Colors.white)

                              ),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove_red_eye),
                                onPressed: (){
                                  controller.obscureRePassword();
                                },
                              ),
                              border:OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                  borderSide:Get.theme.brightness == Brightness.light?
                                  BorderSide.none:BorderSide(color: Colors.white)
                              )
                          ),
                        ),
                        SizedBox(height: 25,),
                        Container(
                          decoration: BoxDecoration(
                              color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
                              border: Border.all(color: controller.agreementState.value == -1?Colors.red:Colors.transparent),
                              borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                          ),
                          child: InkWell(
                            onTap: ()=>controller.onReadAgreementCheck(),
                            child: Row(
                              children: [
                                CircularCheckBox(
                                    value: controller.readAgreement.value,
                                    onChanged: (check)=>controller.onReadAgreementCheck()
                                ),
                                Text('I have read the '),
                                InkWell(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                                    child: Text('agreement',style: TextStyle(color: Colors.blue),),
                                  ),
                                  onTap: (){
                                    Get.defaultDialog(
                                        title: 'Terms and Conditions',
                                        titleStyle: TextStyle(color: Get.theme.brightness== Brightness.light?Colors.black87:Colors.white,),
                                        content: Container(
                                            child:
                                            Column(children: [
                                              Row(
                                                children: [
                                                  CircularCheckBox(value: true, onChanged: (check){}),
                                                  Expanded(
                                                    child: Text(
                                                      " I agree to the terms and conditions and consent to the processing of my health data and being contacted regarding my prescriptions when required.",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  CircularCheckBox(value: true, onChanged: (check){}),
                                                  Expanded(
                                                    child: Text(
                                                      " I agree to nominate Newport pharmacy nomination, to receive and deliver my prescriptions.",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                children: [
                                                  CircularCheckBox(value: true, onChanged: (check){}),
                                                  Expanded(
                                                    child: Text(
                                                      " I authorize Newport Pharmacy to access my summary care record when required, to safely dispense my medication.",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],)
                                        )
                                    );
                                  },
                                )
                              ],
                            ),
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
                                  onPressed:controller.registerStatus.value == StateStatus.LOADING?null:() {
                                   if(controller.readAgreement.value){
                                     if (_formKey.currentState.validate()) {
                                       // Get.snackbar('processingDataTxt'.tr, '');
                                       Map<String, dynamic> jsonMap = {
                                         'name': firstNameController.text,
                                         'family':lastNameController.text,
                                         'email': emailController.text,
                                         'password': passwordController.text,
                                         'password_confirmation': retypePasswordController.text,
                                       };
                                       controller.register(jsonMap);
                                     }
                                   }
                                   else
                                     controller.agreementState.value = -1;
                                     
                                  },
                                  child: controller.registerStatus.value == StateStatus.LOADING?Container(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(),
                                  ):Text('Register'.tr,style: TextStyle(color: Colors.white),)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // CustomPaint(
            //   painter: LogoPainter(),
            //   child:
            //
            // )
        )
    );
  }

}
