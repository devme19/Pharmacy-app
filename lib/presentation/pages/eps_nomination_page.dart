import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/presentation/controllers/eps_nomination_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/presentation/pages/widget/pay_widget.dart';
import 'package:navid_app/utils/state_status.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:intl/intl.dart';

import 'widget/my_check_box.dart';
class EpsNominationPage extends StatelessWidget{
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController surgeryNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nhsNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController townController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  ScrollController _scrollController = new ScrollController();
  UserEntity userInfo = new UserEntity();
  FocusNode town;
  int gender;
  int id;
  Gender gnd;
  bool isDependent;
  EpsNominationController epsNominationController = Get.find();
  UserController userController = Get.put(UserController());
  RoundCheckBox roundCheckBox1,roundCheckBox2;
  String title="EPS Profile";
  double padding = 16;
  bool registered = false;
  String paymentReason="";
  EpsNominationPage(){
    gnd = null;
    if(Get.arguments != null) {
      if(Get.arguments is bool) {
        registered = Get.arguments;
        title = "Edit Profile";
        isDependent = false;
        userController.getUserInfo(setUserInfo);
      } else
      {
        id = Get.arguments;
        if(id != -1) {
          userController.getDependent(id.toString(), setUserInfo);
          title = "Edit Dependent";
        } else
          title = "Add Dependent";
      }
      // userController.get
    }
    else {
      title = "Edit Profile";
      isDependent = false;
      userController.getUserInfo(setUserInfo);
    }
  }
  setUserInfo(UserEntity usrInfo){
    userInfo = usrInfo;
    nameController.text = userInfo.name;
    lastNameController.text = userInfo.family;
    phoneNumberController.text = userInfo.phone;
    emailController.text = userInfo.email;
    nhsNumberController.text = userInfo.nhs_number;
    addressController.text = userInfo.address;
    address2Controller.text = userInfo.address_2;
    townController.text = userInfo.city;
    postCodeController.text = userInfo.postalcode;
    surgeryNameController.text = userInfo.gp_address;
    if(userInfo.payment_code == 0)
      epsNominationController.yes.value = true;
    else
      if(userInfo.payment!= null)
        if(userInfo.payment.id != null)
          epsNominationController.no.value = true;
    epsNominationController.setDate(DateTime.parse(userInfo.birthday));
    if(userInfo.payment!= null) {

      epsNominationController.payMethod([userInfo.payment.id.toString(),userInfo.payment.title]);
      epsNominationController.visibleAlert.value = false;
    }
    switch(userInfo.gender.toLowerCase()){
      case("male"):
        gnd = Gender.Male;
        break;
      case("female"):
        gnd = Gender.Female;
        break;
        case("other"):
          gnd = Gender.Others;
          break;
    }
    gender = gnd.index;
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    town = FocusNode();
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Container(
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
        body:
        Form(
          key: _formKey,
          child:
          Obx(()=> (userController.getUserInfoState.value == StateStatus.LOADING ||
              userController.getDependentState.value == StateStatus.LOADING)?
          SpinKitDualRing(color: Colors.blue,lineWidth: 2,):
          buildView(context))
        )
    );
  }
  Widget buildView(context){
    final node = FocusScope.of(context);
    return  Container(
      margin: EdgeInsets.only(top: 16,left: 16,right: 16),
      child:
      SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: TextFormField(
                controller: nameController,
                textInputAction: TextInputAction.next,
                validator: (value){
                  if(value.isEmpty){
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                    return 'first name is required'.tr;

                  }
                  else return null;
                },
                onEditingComplete: () => node.nextFocus(),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                    labelText: 'First Name (required)',
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
            SizedBox(height: padding,),
            TextFormField(
              controller: lastNameController,
              textInputAction: TextInputAction.next,
              validator: (value){
                if(value.isEmpty){
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                  return 'last name is required'.tr;
                }
                else return null;
              },
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: 'Last Name (required)',
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
                  flex: 5,
                  child: TextFormField(
                    maxLines: null,
                    controller: addressController,
                    validator: (value){
                      if(value.isEmpty){
                        _scrollController.animateTo(
                          0.0,
                          curve: Curves.easeOut,
                          duration: const Duration(milliseconds: 300),
                        );
                        return 'Address is required'.tr;
                      }
                      else
                        return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                        labelText: 'Address (required)',
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
                    onEditingComplete: () => node.nextFocus(),
                  ),
                ),
              ],
            ),
            SizedBox(height: padding,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextFormField(
                    maxLines: null,
                    controller: address2Controller,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                        labelText: 'Address line 2',
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
                    onEditingComplete: () => node.nextFocus(),
                  ),
                ),
              ],
            ),
            SizedBox(height: padding,),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              controller: postCodeController,
              onEditingComplete: () => node.nextFocus(),
              validator: (value){
                if(value.isEmpty){
                  _scrollController.animateTo(
                    0.0,
                    curve: Curves.easeOut,
                    duration: const Duration(milliseconds: 300),
                  );
                  return 'Post code is required'.tr;
                }
                else
                  return null;
              },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: 'Post Code (required)',
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
              keyboardType: TextInputType.emailAddress,
              validator: (value){
                if(id == null) {
                  if (value.isEmpty) {
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                    return 'Email address is required';
                  }
                  else if (!GetUtils.isEmail(value)) {
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                    return 'Email format is incorrect'.tr;
                  }
                }
                else
                if(value.isNotEmpty){
                  if(!GetUtils.isEmail(value)) {
                    _scrollController.animateTo(
                      0.0,
                      curve: Curves.easeOut,
                      duration: const Duration(milliseconds: 300),
                    );
                    return 'Email format is incorrect'.tr;
                  }
                }
                return null;
              },
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: id !=null ?'Email (optional)':'Email (required)'  ,
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
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              validator: (value){
                if(value.isEmpty){
                  return 'Phone number is required'.tr;
                }
                else
                  return null;
              },
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: 'Phone Number (required)',
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
              controller: surgeryNameController,
              validator: (value){
                if(value.isEmpty){
                  return 'Surgery name is required'.tr;
                }
                else
                  return null;
              },
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: 'Surgery Name (required)',
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
              focusNode: town,
              controller: townController,
              onEditingComplete: () => node.nextFocus(),
              // validator: (value){
              //   if(value.isEmpty){
              //     return 'Town/City is required'.tr;
              //   }
              //   else
              //     return null;
              // },
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: 'Town/City (optional)',
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
              controller: nhsNumberController,
              keyboardType: TextInputType.number,
              onEditingComplete: () => node.nextFocus(),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                  labelText: 'NHS Number (if known)',
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
            Container(
              padding: EdgeInsets.only(left:8.0,right: 8.0,top: 18.0,bottom: 18.0),
              decoration: BoxDecoration(
                  color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              ),
              child:
              InkWell(
                onTap: (){
                  // DatePicker.showDatePicker(
                  //     context,
                  //     showTitleActions: true,
                  //     minTime: DateTime(1800, 1, 1),
                  //     maxTime: DateTime(2050, 1, 1),
                  //     theme: DatePickerTheme(
                  //         headerColor:Get.theme.primaryColor,
                  //         backgroundColor: Get.theme.scaffoldBackgroundColor,
                  //         itemStyle: TextStyle(
                  //             color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 18),
                  //         doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
                  //
                  //     onChanged: (date) {
                  //       print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                  //     }, onConfirm: (date) {
                  //       epsNominationController.onBirthDateConfirm(date);
                  //       print('confirm $date');
                  //     },
                  //     currentTime: DateTime.now(), locale: LocaleType.en);
                  _selectDate(context);
                },
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: AutoSizeText(
                              'Tap to select birth date',
                              maxLines: 1,
                              style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                            )
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(epsNominationController.birthDateStr.value,
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: padding,),
            Container(
              decoration: BoxDecoration(
                  color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))
              ),
              padding: EdgeInsets.only(bottom: 16),
              child: GenderPickerWithImage(
                selectedGender: gnd,
                showOtherGender: true,
                verticalAlignedText: true,
                selectedGenderTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
                unSelectedGenderTextStyle: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.normal),
                onChanged: (Gender gd) {
                  gender = gd.index;
                  gnd = gd;
                  print(gender);
                },
                //Alignment between icons
                equallyAligned: true,

                animationDuration: Duration(milliseconds: 100),
                isCircular: true,
                // default : true,
                opacityOfGradient: 0.4,
                padding: const EdgeInsets.all(5),
                size: 70, //default : 40
              ),
            ),
            SizedBox(height: padding,),
            epsNominationController.payOrNot.value?
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left:16.0,right: 16.0,top: 18.0,bottom: 18.0),
                  decoration: BoxDecoration(
                      color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
                      borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Payment / Exemption',style: TextStyle(fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: ()=>epsNominationController.onYesCheck(),
                        child: Row(
                          children: [
                            CircularCheckBox(
                                value: epsNominationController.yes.value,
                                onChanged: (check)=>epsNominationController.onYesCheck()
                            ),
                            Expanded(child: Text('I pay for my prescriptions')),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: ()=>epsNominationController.onNoCheck(),
                        child: Row(
                          children: [
                            CircularCheckBox(
                              value: epsNominationController.no.value,
                              onChanged: (check)=>epsNominationController.onNoCheck(),
                            ),
                            Expanded(child: Text('I have an exemptions (please choose)')),
                          ],
                        ),
                      ),
                      epsNominationController.no.value?
                      Column(
                        children: [
                          InkWell(
                            onTap: (){
                              Get.defaultDialog(
                                  title: 'Select an exemption',
                                  titleStyle: TextStyle(color: Get.theme.brightness== Brightness.light?Colors.black87:Colors.white,),
                                  content: Container(
                                      height: 400,
                                      child: PayWidget(parentAction: paymentMethod,))
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0,bottom: 8.0),
                              decoration: BoxDecoration(
                                  color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
                                  borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                              ),
                              child: Column(
                                children: [
                                  Divider(),
                                  SizedBox(height: 8,),
                                  Row(
                                    children: [
                                      Expanded(child: Text('Tap to select exemption',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),)),
                                      epsNominationController.visibleAlert.value?Icon(Icons.error_outline,color: Colors.red,):Container()
                                    ],
                                  ),
                                  epsNominationController.selectedPayMethod.length!=0?
                                  Row(children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(epsNominationController.selectedPayMethod[1]),
                                      ),
                                    )
                                  ],):Container()
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: padding,),
                        ],
                      ):Container(),
                      // epsNominationController.selectedPayMethod.length!=0?
                      // Row(children: [
                      //   Expanded(
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text(epsNominationController.selectedPayMethod[1]),
                      //     ),
                      //   )
                      // ],):Container()
                    ],
                  ),
                ),
                SizedBox(height: padding,),
              ],
            ):Container(),
            // SizedBox(height: padding,),



            userInfo.address== null?
            Container(
                decoration: BoxDecoration(
                    color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                ),
              child: InkWell(
                onTap: ()=>epsNominationController.onReadAgreementCheck(),
                child: Row(
                  children: [
                    CircularCheckBox(
                        value: epsNominationController.readAgreement.value,
                        onChanged: (check)=>epsNominationController.onReadAgreementCheck()
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
                                          "I agree to the terms and conditions and consent to the processing of my health data and being contacted regarding my prescriptions when required.",
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
                                          "I agree to nominate Newport pharmacy nomination. to receive and deliver my prescriptions.",
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
                                          "I authorize Newport Pharmacy to access my summary care record when required, to safely dispense my medication.",
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
            )
            // Column(
            //   children: [
            //     Container(
            //       height: 120,
            //       padding: EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //           color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
            //           borderRadius: BorderRadius.all(Radius.circular(borderRadius))
            //       ),
            //       child:
            //       Row(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               CircularCheckBox(
            //                 value: epsNominationController.check1.value,
            //                 onChanged: (check)=>epsNominationController.onCheckPress1(),
            //               ),
            //             ],
            //           ),
            //           Expanded(child:
            //           Column(
            //             children: [
            //               Expanded(
            //                 flex: 3,
            //                 child: InkWell(
            //                   onTap: ()=>epsNominationController.onCheckPress1(),
            //                   child: Container(
            //                     margin: EdgeInsets.only(top: 8),
            //                     child: AutoSizeText(
            //
            //                       "I agree to the terms and conditions and consent to the processing of my health data and being contacted regarding my prescriptions when required.",
            //                       maxLines: 5,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                 flex: 1,
            //                   child: Row(
            //                 children: [
            //                   Expanded(
            //                     child: InkWell(
            //                       child: AutoSizeText(
            //                         'READ TERMS + CONDITIONS',style: TextStyle(color: Colors.lightBlue),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ))
            //             ],
            //           )),
            //         ],
            //       ),
            //     ),
            //     // SizedBox(height: 25,),
            //     SizedBox(height: padding,),
            //     Container(
            //       height: 110,
            //       padding: EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //           color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
            //           borderRadius: BorderRadius.all(Radius.circular(borderRadius))
            //       ),
            //       child: Row(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               CircularCheckBox(
            //                 value: epsNominationController.check2.value,
            //                 onChanged: (check)=>epsNominationController.onCheckPress2(),
            //               ),
            //             ],
            //           ),
            //           Expanded(child:
            //           Column(
            //             children: [
            //               Expanded(
            //                 flex: 4,
            //                 child: InkWell(
            //                   onTap: ()=>epsNominationController.onCheckPress2(),
            //                   child: Container(
            //                     margin: EdgeInsets.only(top: 8),
            //                     child: AutoSizeText(
            //                       "I agree to nominate Newport pharmacy nomination. to receive and deliver my prescriptions.",
            //                       maxLines: 5,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                   flex: 2,
            //                   child: Row(
            //                     children: [
            //                       Expanded(
            //                         child: InkWell(
            //                           child: AutoSizeText(
            //                             'INFORMATION ABOUT NHS PHARMACY NOMINATION ',style: TextStyle(color: Colors.lightBlue),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //             ],
            //           )),
            //         ],
            //       ),
            //     ),
            //     SizedBox(height: padding,),
            //     Container(
            //       padding: EdgeInsets.all(8.0),
            //       decoration: BoxDecoration(
            //           color: Get.theme.brightness==Brightness.light?Colors.white:Colors.white24,
            //           borderRadius: BorderRadius.all(Radius.circular(borderRadius))
            //       ),
            //       height: 100,
            //       child: Row(
            //         children: [
            //           Column(
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               CircularCheckBox(
            //                 value: epsNominationController.check3.value,
            //                 onChanged: (check)=>epsNominationController.onCheckPress3(),
            //               ),
            //             ],
            //           ),
            //           Expanded(child:
            //           Column(
            //             children: [
            //               Expanded(
            //                 flex: 4,
            //                 child: InkWell(
            //                   onTap: ()=>epsNominationController.onCheckPress3(),
            //                   child: Container(
            //                     margin: EdgeInsets.only(top: 8),
            //                     child: AutoSizeText(
            //                       "I authorize Newport Pharmacy to access my summary care record when required, to safely dispense my medication.",
            //                       maxLines: 5,
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               Expanded(
            //                   flex: 2,
            //                   child: Row(
            //                     children: [
            //                       Expanded(
            //                         child: InkWell(
            //                           child: AutoSizeText(
            //                             'INFORMATION ABOUT SUMMARY CARE RECORD',style: TextStyle(color: Colors.lightBlue),
            //                           ),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //             ],
            //           )),
            //         ],
            //       ),
            //     ),
            //   ],
            // )
                :Container(),
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
                      // color: Colors.blueGrey,
                      padding: EdgeInsets.only(top: 20,bottom: 20),
                      onPressed:userController.updateDependentState.value == StateStatus.LOADING||
                          userController.addDependentState.value == StateStatus.LOADING||
                          userController.updateUserState.value == StateStatus.LOADING
                          ?null:() {
                        List<String> validation = new List();
                        String genderStr;
                        switch(gender){
                          case(0):
                            genderStr = "Male";
                            break;
                          case(1):
                            genderStr = "Female";
                            break;
                          case(2):
                            genderStr = "Other";
                            break;
                        }
                        if(genderStr == null ||  (userInfo.address == null && epsNominationController.mBirthDate.value == "")
                        ) {
                          if(userInfo.address == null && (epsNominationController.readAgreement.value == false ))
                            validation.add("Should accept agreement");
                          if (genderStr == null)
                            validation.add("Select gender");
                          if (epsNominationController.mBirthDate.value == "")
                            validation.add("Select date of birth");
                          MyAlertDialog.show(validation, false,null,null);
                          _formKey.currentState.validate();
                        }
                        else
                        if (_formKey.currentState.validate()) {
                          Map<String, dynamic> jsonMap;
                          jsonMap = {
                            'name': nameController.text,
                            'family': lastNameController.text,
                            'gp_address': surgeryNameController.text,
                            'email': emailController.text,
                            'phone': phoneNumberController.text,
                            'nhs_number': nhsNumberController.text,
                            'address': addressController.text,
                            'address_2': address2Controller.text,
                            'city': townController.text,
                            'postalcode': postCodeController.text,
                            'birthday': epsNominationController
                                .mBirthDate.value,
                            'gender': genderStr,
                            'payment_none_id':epsNominationController.selectedPayMethod.length!=0?epsNominationController.selectedPayMethod[0]:null,
                            'payment_code':epsNominationController.yes.value?0:1,
                          };
                          if(id == null)
                            userController.updateUser(jsonMap,registered);
                          else
                          if(id == -1)
                            userController.addDependent(jsonMap);
                          else
                            userController.updateDependent(id.toString(), jsonMap);
                                // controller.register(body);
                        }
                      },
                      child: userController.updateDependentState.value == StateStatus.LOADING||
                              userController.addDependentState.value == StateStatus.LOADING||
                              userController.updateUserState.value == StateStatus.LOADING?
                      Container(
                        width: 15,
                        height: 15,
                        child: CircularProgressIndicator(),
                      ):
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          userController.updateDependentState.value == StateStatus.ERROR||
                              userController.addDependentState.value == StateStatus.ERROR||
                              userController.updateUserState.value == StateStatus.ERROR?
                          Column(
                            children: [
                              Icon(Icons.wifi_off,color: Colors.white,),
                              Text('Connection failed'),
                              Text('Tap to retry')
                            ],
                          ):Text('Save'.tr )
                        ],
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
  paymentMethod(List selectedMethod){
    epsNominationController.payMethod(selectedMethod);
    epsNominationController.visibleAlert.value = false;
    Get.back();
  }
  Future<void> _selectDate(BuildContext context)async{
    DateTime picked = await showDatePicker(
        context: context,
        // locale:Locale('ps'),
        initialDate: epsNominationController.selectedDate.value,
        firstDate: DateTime(1820, 8),
        lastDate: DateTime(2101));
    // DateTimePicker(
    //   type: DateTimePickerType.date,
    //   initialValue: '',
    //   dateMask: 'd MMM, yyyy',
    //   firstDate: DateTime(2000),
    //   lastDate: DateTime(2100),
    //   dateLabelText: 'Date',
    //   onChanged: (val) => print(val),
    //   validator: (val) {
    //     print(val);
    //     return null;
    //   },
    //   onSaved: (val) {
    //     // epsNominationController.setDate(val);
    //     print(val);
    //   },
    // );
    if (picked != null && picked != epsNominationController.selectedDate.value)
      epsNominationController.setDate(picked);

  }

}