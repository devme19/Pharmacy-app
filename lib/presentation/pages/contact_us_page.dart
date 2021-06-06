import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/contact_us_controller.dart';
import 'package:navid_app/utils/state_status.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsPage extends GetView<ContactUsController> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  // FocusNode firstNameFocus,lastNameFocus,emailFocus,passwordFocus,retypePasswordFocus;
  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus= FocusNode();
  FocusNode emailFocus= FocusNode();
  FocusNode phoneFocus= FocusNode();
  FocusNode messageFocus= FocusNode();
  double padding = 10.0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        actions: [
          Container(
              margin: EdgeInsets.only(right: 8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
            children: [
              Obx(()=>
                  Form(
                    key: _formKey,
                    child:
                    Container(
                      // margin: EdgeInsets.all(64),
                      // padding: EdgeInsets.all(32),
                      child:
                      Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              SizedBox(height: padding,),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: lastNameController,
                                focusNode: lastNameFocus,
                                validator: (value){
                                  if(value.isEmpty){
                                    return 'last name is required'.tr;
                                  }
                                  else return null;
                                },
                                onEditingComplete: () {
                                  FocusScope.of(context).requestFocus(emailFocus);
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                                    labelText: 'Last Name',
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
                              SizedBox(height: padding,),
                              TextFormField(
                                textInputAction: TextInputAction.next,
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
                                  FocusScope.of(context).requestFocus(phoneFocus);
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
                              SizedBox(height: padding,),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                focusNode: phoneFocus,
                                controller: phoneNumberController,
                                keyboardType: TextInputType.phone,
                                onEditingComplete: () {
                                  FocusScope.of(context).requestFocus(messageFocus);
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                                    labelText: 'Phone Number',
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
                              SizedBox(height: padding,),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                maxLines: 10,
                                focusNode: messageFocus,
                                controller: messageController,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                                    labelText: 'Write Your Message',
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
                              SizedBox(height: padding,),
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
                                        onPressed:controller.sendStatus.value == StateStatus.LOADING?null:() {
                                          if (_formKey.currentState.validate()) {
                                            Map<String, dynamic> jsonMap;
                                            // Get.snackbar('processingDataTxt'.tr, '');
                                            if(phoneNumberController.text == '')
                                            jsonMap = {
                                              'first_name': firstNameController.text,
                                              'last_name':lastNameController.text,
                                              'email': emailController.text,
                                              'message': messageController.text,
                                            };
                                            else jsonMap = {
                                              'first_name': firstNameController.text,
                                              'last_name':lastNameController.text,
                                              'email': emailController.text,
                                              'phone_number': phoneNumberController.text,
                                              'message': messageController.text,
                                            };
                                            controller.sendMessage(jsonMap,done);
                                          }
                                        },
                                        child: controller.sendStatus.value == StateStatus.LOADING?Container(
                                          width: 15,
                                          height: 15,
                                          child: CircularProgressIndicator(),
                                        ):Text('Send Message'.tr,style: TextStyle(color: Colors.white),)
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
              ),
              SizedBox(height: padding,),
              InkWell(
                onTap: (){
                  MapsLauncher.launchCoordinates(51.9844625945254, 0.21473608465497732);
                },
                child: Container(
                  padding: EdgeInsets.all(16.0),

                  decoration: BoxDecoration(
                      boxShadow: [
                        Get.theme.brightness==Brightness.light? BoxShadow(
                          color: Colors.blueGrey.shade100,
                          spreadRadius: 1,
                          blurRadius:5,
                          // Get.theme.brightness == Brightness.light? 15:5,
                          offset: Offset(0, 1), // changes position of shadow
                        ):BoxShadow(
                          color: Colors.blueGrey.shade100,
                          spreadRadius: 0,
                          blurRadius:0,
                          // Get.theme.brightness == Brightness.light? 15:5,
                          offset: Offset(0, 0), // changes position of shadow
                        ),
                      ],
                      color:Get.theme.brightness == Brightness.light? Colors.white:Colors.grey.shade800,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Address",style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText("The Brown House, High Street, Newport, CB11 3QY",maxLines: 2,)
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: padding,),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      Get.theme.brightness==Brightness.light? BoxShadow(
                        color: Colors.blueGrey.shade100,
                        spreadRadius: 1,
                        blurRadius:5,
                        // Get.theme.brightness == Brightness.light? 15:5,
                        offset: Offset(0, 1), // changes position of shadow
                      ):BoxShadow(
                        color: Colors.blueGrey.shade100,
                        spreadRadius: 0,
                        blurRadius:0,
                        // Get.theme.brightness == Brightness.light? 15:5,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                    color:Get.theme.brightness == Brightness.light? Colors.white:Colors.grey.shade800,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                ),
                child: InkWell(
                  onTap: (){
                    _launchURL('tel:01799540968');
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Phone",style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: AutoSizeText('01799 540968')
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.all(16.0),
              //   decoration: BoxDecoration(
              //       boxShadow: [
              //         Get.theme.brightness==Brightness.light? BoxShadow(
              //           color: Colors.blueGrey.shade100,
              //           spreadRadius: 1,
              //           blurRadius:5,
              //           // Get.theme.brightness == Brightness.light? 15:5,
              //           offset: Offset(0, 1), // changes position of shadow
              //         ):BoxShadow(
              //           color: Colors.blueGrey.shade100,
              //           spreadRadius: 0,
              //           blurRadius:0,
              //           // Get.theme.brightness == Brightness.light? 15:5,
              //           offset: Offset(0, 0), // changes position of shadow
              //         ),
              //       ],
              //       color:Get.theme.brightness == Brightness.light? Colors.white:Colors.grey.shade800,
              //       borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              //   ),
              //   child: Column(
              //     children: [
              //       Row(
              //         children: [
              //           Text("Email",style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold,color: Colors.black),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
        ),
          ),));
  }
  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : print ('Could not launch $_url');

done(bool val){
  firstNameController.clear();
  lastNameController.clear();
  emailController.clear();
  phoneNumberController.clear();
  messageController.clear();
}
}
