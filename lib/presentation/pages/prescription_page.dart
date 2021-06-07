import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/data/model/drug_model.dart';
import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/presentation/controllers/prescription_controller.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/presentation/pages/widget/animated_list_widget.dart';
import 'package:navid_app/presentation/pages/widget/group_check_box.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';
import 'package:permission_handler/permission_handler.dart';


import 'widget/medicine_widget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:qrscan/qrscan.dart' as scanner;

// ignore: must_be_immutable
class PrescriptionPage extends GetView<PrescriptionController>{


  List<MedicineWidget> medicineList = [];
  int selectedIndex = 0;
  String selectedUserId = "";
  TextEditingController descriptionController = TextEditingController();
  Data order;
  bool isEdit = false;
  bool reorder;
  Image image = Image(image: AssetImage('asset/images/user.png'),width: 50,height: 50,color: Colors.white,);
  ValueChanged<String> parentAction;
  int page = 1;
  String parameters;
  String searchParams="";
  String dependency="";
  ValueChanged<String> parentUpdate;
  ScrollController _scrollController = ScrollController();
  _scrollListener() {
    if (_scrollController.position.userScrollDirection==ScrollDirection.reverse) {
      controller.changeVisibility(false);
    }
    else if(_scrollController.position.userScrollDirection==ScrollDirection.forward){
      controller.changeVisibility(true);
    }
  }
  ScrollController _drugsScrollController = ScrollController();
  String createParameters(){
    String result = "?page=$page";
    if(searchParams!="")
      result+="&search=$searchParams";
    if(dependency!="")
      result+="&dependency=$dependency";
    return result;
  }
  _drugsScrollListener() {
    if(_drugsScrollController.position.userScrollDirection==ScrollDirection.forward){
    controller.changeErrorVisibility(false);
    }
    else if(_drugsScrollController.position.userScrollDirection==ScrollDirection.reverse){
      controller.changeErrorVisibility(true);
    }
    if (_drugsScrollController.offset >= _drugsScrollController.position.maxScrollExtent &&
        !_drugsScrollController.position.outOfRange) {
      if(controller.drugsList.length !=0)
        page = controller.pageIndex+1;
      controller.getDrugs(createParameters());
    }
  }
  action(bool done){
    if(order!=null) {
      if(!reorder)
        isEdit = true;
      if (order.user_type == 'user')
        selectedAccount(0);
      else
        for (int index = 0; index < controller.accounts.length; index++)
          if (controller.accounts[index].id == order.familyid) {
            selectedAccount(index);
            break;
          }
    }
    else {
      // controller.getDrugs("");
      image =
          Image(image: AssetImage(
              controller.accounts[0].gender.toLowerCase() == "male"?
              'asset/images/male.png':
              controller.accounts[0].gender.toLowerCase() == "female"?
              'asset/images/female.png':
              controller.accounts[0].gender.toLowerCase() == "other"?
              'asset/images/other.png':''
          ));
    }
  }
  PrescriptionPage(){
    _scrollController.addListener(_scrollListener);
    _drugsScrollController.addListener(_drugsScrollListener);
    order = Get.arguments[0];
    reorder = false;
    if (Get.arguments[3] != null) parentUpdate = Get.arguments[3];
    if (Get.arguments[2] != null) parentAction = Get.arguments[2];
    if (Get.arguments[1] != null) reorder = Get.arguments[1];
    controller.getAccounts(action);

    if (order != null) {
      if (!reorder) isEdit = true;
      for (var item in order.orderlist)
        controller.addItem(item.title, item.quantity.toString(), editOrder);
      descriptionController.text = order.description;
    }
  }
  clearDescription(bool value){
    descriptionController.clear();
  }

  accountsWidget(context){
    List<Item> items = [];
    for(var user in controller.accounts){
      items.add(Item(title: user.name+" "+user.family,id: user.id.toString(),gender: user.gender));
    }
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 350,child:
      GroupCheckBox(
        title: "Select An Account",
        parentAction: selectedAccount,
        checkedIndex: selectedIndex,
        items: items,
      )
        ,),
    );
  }
  selectedAccount(int index){
    selectedIndex = index;
    controller.setAccountName(controller.accounts[index].name+" "+controller.accounts[index].family);
    image =
        Image(image: AssetImage(
        controller.accounts[index].gender.toLowerCase() == "male"?
        'asset/images/male.png':
        controller.accounts[index].gender.toLowerCase() == "female"?
        'asset/images/female.png':
        controller.accounts[index].gender.toLowerCase() == "other"?
        'asset/images/other.png':''
    ));
    selectedUserId = controller.accounts[index].id.toString();
    if(!isEdit&&!reorder) Get.back();
    if(selectedIndex == 0)
      dependency="";
    else
      dependency=selectedUserId;
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
        appBar:AppBar(
          title: Text('Prescription'),
        ),

        // floatingActionButton: FloatingActionButton(
        //   backgroundColor:Get.theme.primaryColor,
        //   foregroundColor: Colors.white,
        //   child: Icon(Icons.add),
        //   onPressed: ()=>addMedicine(null),
        // ),
        body:
        Obx(()=>
            Column(
              children: [
                Expanded(
                  flex: 9,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    // height: Get.mediaQuery.orientation == Orientation.landscape?
                    // Get.height*3:Get.height-appBar.preferredSize.height-36,
                    child:

                    Column(
                      children: [
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: AutoSizeText(
                        //         "You can order your repeat prescription by filling the form below.",
                        //         maxLines: 2,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(height: 25,),
                        controller.selectUserVisible.value?
                        Column(
                          children: [
                            InkWell(
                              child:
                              Container(
                                height: 80,
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
                                child:
                                Row(
                                  children: [
                                    Expanded(
                                      flex:1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration:BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:Get.theme.accentColor.withAlpha(50),
                                                // border: Border.all(color: Colors.blueAccent)
                                              ),
                                              margin: EdgeInsets.all(8.0),
                                              padding: EdgeInsets.all(8.0),
                                              child: Center(
                                                child: image,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(flex:5,
                                      child: isEdit||reorder?
                                      Row(
                                        children: [
                                          Text(controller.accountName.value),
                                        ],
                                      )
                                          :Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text("Tap to select user",style: TextStyle(fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          controller.getAccountsState.value == StateStatus.LOADING?
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SpinKitDualRing(
                                                color: Colors.blue,
                                                lineWidth: 2,
                                                size: 15,
                                              ),
                                            ],
                                          ):controller.getAccountsState.value == StateStatus.ERROR?
                                          InkWell(
                                            onTap: ()=>controller.getAccounts(action),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.wifi_off,color: Colors.red,),
                                                SizedBox(width: 8.0,),
                                                Text('Error receiving data. Tap to retry'),
                                              ],
                                            ),
                                          ):controller.getAccountsState.value == StateStatus.SUCCESS?
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text(controller.accountName.value,),
                                            ],
                                          ):Container()
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              onTap: isEdit||reorder?null:(){
                                if(controller.accounts==null)
                                  controller.getAccounts(action);
                                else
                                  accountsWidget(context);
                              },
                            ),
                            SizedBox(height: 8,),
                          ],
                        ):Container(),
                        Container(
                          height: 100,
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: InkWell(
                                    child:
                                    Container(
                                        padding: EdgeInsets.all(6.0),
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
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(child: Icon(Icons.add,color: Get.theme.brightness==Brightness.light?Get.theme.primaryColor.withOpacity(0.6):Colors.grey.withOpacity(0.5),),),
                                            Expanded(flex:2,child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AutoSizeText('Add Medicine',maxLines: 2,textAlign: TextAlign.center,),
                                              ],
                                            )),
                                          ],
                                        )),
                                    onTap: ()=>addMedicine(null),
                                  )
                                // RaisedButton(
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(borderRadius),
                                //       // side: BorderSide(color: Colors.grey.shade200)
                                //     ),
                                //     // color: Colors.blueGrey,
                                //     // padding: EdgeInsets.only(top: 20,bottom: 20),
                                //     onPressed:() {
                                //       addMedicine(null);
                                //     },
                                //     child: Container(margin:EdgeInsets.only(top:20,bottom: 20),child: AutoSizeText('Add Medicine'.tr,maxLines: 1,))
                                // ),
                              ),
                              Expanded(
                                  flex: 1,
                                  child:
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          child: Container(
                                            margin: EdgeInsets.only(left:6.0),
                                            padding: EdgeInsets.all(6.0),
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
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Expanded(child: Icon(Icons.history,color: Get.theme.brightness==Brightness.light?Get.theme.primaryColor.withOpacity(0.6):Colors.grey.withOpacity(0.5),)),
                                                  Expanded(flex:2,child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      AutoSizeText('Choose from history',maxLines: 2,textAlign: TextAlign.center,),
                                                    ],
                                                  )),
                                                ],
                                              )),
                                          onTap: ()=>_showMultiSelect(context),
                                        ),
                                      ),
                                    ],
                                  )
                                // RaisedButton(
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(borderRadius),
                                //       // side: BorderSide(color: Colors.grey.shade200)
                                //     ),
                                //     // color: Colors.blueGrey,
                                //     // padding: EdgeInsets.only(top: 20,bottom: 20),
                                //     onPressed:() {
                                //       _showMultiSelect(context);
                                //     },
                                //     child: Container(margin:EdgeInsets.only(top:20,bottom: 20),child: AutoSizeText('Choose from history'.tr,maxLines: 1,))
                                // ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(child: InkWell(
                                      child: Container(
                                          margin: EdgeInsets.only(left:6.0),
                                          padding: EdgeInsets.all(6.0),
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
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Icon(Icons.qr_code_scanner_rounded,color: Get.theme.brightness==Brightness.light?Get.theme.primaryColor.withOpacity(0.6):Colors.grey.withOpacity(0.5),)

                                              // Icon(Icons.qr_code_scanner_rounded)
                                              ),
                                              Expanded(flex:2,child:
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  AutoSizeText('Scan medicine barcode',maxLines: 2,textAlign: TextAlign.center,),
                                                ],
                                              )),
                                            ],
                                          )),
                                      onTap: () async {
                                        if (await Permission.camera.request().isGranted) {
                                          String cameraScanResult = await scanner.scan();
                                          if(cameraScanResult != null)
                                            controller.getDrugByBarCode(cameraScanResult,editOrder);
                                        }
                                      },
                                    ))
                                  ],),
                              ),
                            ],
                          ),
                        ),
                        controller.medicineList.length>0?
                        Column(
                          children: [
                            SizedBox(height: 8,),
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              height: 70,
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
                              child: Row(children: [
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      Expanded(flex:3,child: Padding(
                                        padding: const EdgeInsets.only(left:16.0),
                                        child: AutoSizeText("Title",style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,),
                                      )),
                                      Expanded(flex:2,child: AutoSizeText("Quantity",style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,maxLines: 1,)),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText("Actions",style: TextStyle(fontWeight: FontWeight.bold),maxLines: 1,)
                                    ],),
                                ),
                              ],),
                            ),
                          ],
                        ):Container(),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                SizedBox(height: 3,),
                                orders(),
                                SizedBox(height: 8,),
                                !isEdit?
                                controller.medicineList.length>0?
                                Padding(
                                  padding: const EdgeInsets.only(top:8.0),
                                  child: TextFormField(
                                    // style: TextStyle(color: isEdit?Colors.grey:Colors.black54),
                                    controller: descriptionController,
                                    maxLines: 10,
                                    minLines: 3,
                                    textInputAction: TextInputAction.done,

                                    onEditingComplete: () {
                                      Get.focusScope.nextFocus();
                                    },
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                                      labelText: 'Leave a note',
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
                                  )
                                ):Container():
                                Container(
                                  margin: EdgeInsets.only(top: 8),
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
                                        children: [Padding(
                                          padding: const EdgeInsets.only(left:8.0,top: 8.0,bottom: 16.0),
                                          child: Text("Note"),
                                        )],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left:8.0,right:8.0,bottom: 8.0),
                                            child: AutoSizeText(descriptionController.text,style: TextStyle(color: Colors.grey),textAlign: TextAlign.start,),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left:16.0,right: 16.0),
                    child: Row(
                      children: [
                        isEdit&&!reorder?
                        Expanded(
                          flex:1,
                          child:
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right:16.0),
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(borderRadius),
                                        // side: BorderSide(color: Colors.grey.shade200)
                                      ),
                                      color: Colors.redAccent,
                                      // padding: EdgeInsets.only(top: 20,bottom: 20),
                                      onPressed:controller.deleteOrderState.value == StateStatus.LOADING?null:() {
                                        Get.defaultDialog(
                                          title: "Delete Order",
                                          content: Text("Are you sure you want to delete it?"),
                                          actions:
                                             <Widget>[

                                              FlatButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                              FlatButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  Get.back();
                                                  controller.deleteOrder(order.id.toString(),parentAction);
                                                },
                                              ),
                                            ],
                                          barrierDismissible: false,
                                        );
                                      },
                                      child: Container(margin:EdgeInsets.only(top: 20,bottom: 20),child:
                                      controller.deleteOrderState.value == StateStatus.LOADING ||
                                          controller.deleteOrderState.value == StateStatus.LOADING?
                                      Container(
                                        width: 15,
                                        height: 15,
                                        child: CircularProgressIndicator(),
                                      ):
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          controller.deleteOrderState.value == StateStatus.ERROR ||
                                              controller.deleteOrderState.value == StateStatus.ERROR?
                                          Column(
                                            children: [
                                              Icon(Icons.wifi_off,color: Colors.white,),
                                              Text('Connection failed'),
                                              Text('Tap to retry')
                                            ],
                                          ):AutoSizeText('Delete'.tr,style: TextStyle(color: Colors.white),maxLines: 1,)
                                        ],
                                      )
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ):Container(),
                        Expanded(
                          flex: 1,
                          child:
                          RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(borderRadius),
                                // side: BorderSide(color: Colors.grey.shade200)
                              ),
                              // color: Colors.blueGrey,
                              // padding: EdgeInsets.only(top: 20,bottom: 20),
                              onPressed:controller.updateOderState.value == StateStatus.LOADING ||
                                  controller.addOderState.value == StateStatus.LOADING?null:() {
                                List<Map<String, dynamic>> jsonMapArray =
                                [];
                                for(var item in controller.medicineList){
                                  jsonMapArray.add(MedicineToPost(title: item.title,quantity: item.quantity).toJson());
                                }
                                Map<String, dynamic> jsonMap;
                                if(jsonMapArray.length !=0) {
                                  if(selectedIndex == 0) {
                                    if (reorder)
                                      jsonMap = {
                                        'orderlist': jsonMapArray,
                                        'description': descriptionController
                                            .text,
                                        'user_type': 'user',
                                        'reorder': order.orderid
                                            .toString()
                                      };
                                    else
                                      jsonMap = {
                                        'orderlist': jsonMapArray,
                                        'description': descriptionController
                                            .text,
                                        'user_type': 'user',
                                      };
                                  }
                                  else
                                    if(reorder)
                                      jsonMap = {
                                        'orderlist': jsonMapArray,
                                        'description': descriptionController.text,
                                        'user_type':'family',
                                        'familyid':selectedUserId,
                                        'reorder': order.id
                                            .toString()
                                      };
                                    else
                                      jsonMap = {
                                        'orderlist': jsonMapArray,
                                        'description': descriptionController.text,
                                        'user_type':'family',
                                        'familyid':selectedUserId
                                      };
                                  if(isEdit)
                                    controller.updateOrder(order.id.toString(), jsonMap,parentUpdate);
                                  else if(controller.accounts[selectedIndex].address!=null) {
                                          controller.addOrder(jsonMap,clearDescription);

                                        } else
                                          MyAlertDialog.show(['Dear '+controller.accounts[selectedIndex].name+' complete your profile to place an order'], true,_getAccounts,controller.accounts[selectedIndex].id);
                                }
                                else
                                {
                                  MyAlertDialog.show(["Enter at least one order"], true,null,null);
                                }
                              },
                              child: Container(margin:EdgeInsets.only(top:20,bottom: 20),child:
                              controller.updateOderState.value == StateStatus.LOADING ||
                                  controller.addOderState.value == StateStatus.LOADING?
                              Container(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(),
                              ):
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  controller.updateOderState.value == StateStatus.ERROR ||
                                      controller.addOderState.value == StateStatus.ERROR?
                                      Column(
                                        children: [
                                          Icon(Icons.wifi_off,color: Colors.white,),
                                          Text('Connection failed'),
                                          Text('Tap to retry')
                                        ],
                                      ):Text(reorder?'Re Order':'Submit Order'.tr )
                                ],
                              )
                              )
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }
  _getAccounts(bool value){
    controller.getAccounts(action);
  }
  void _showMultiSelect(BuildContext context) async {

    controller.listSize.value = 0;
    controller.visibleSearch.value = false;
    controller.drugsList.clear();
    FocusNode searchFocus = FocusNode();
    page = 1;
    searchParams = "";
    TextEditingController searchController = TextEditingController();
    Get.focusScope.unfocus();
    controller.getDrugs(createParameters());
    await showModalBottomSheet(
      isScrollControlled: true, // required for min/max child size
      context: context,
      builder: (ctx) {
        return
          Obx(()=>Container(
              height: controller.drugsList.length == 0 ?controller.getDrugsState.value == StateStatus.ERROR?100:
              controller.getDrugsState.value == StateStatus.SUCCESS?100:10:2/3*Get.height,
              child:
              controller.drugsList.length == 0?
              controller.getDrugsState.value == StateStatus.LOADING?
              // SpinKitDualRing(
              //   color: Colors.blue,
              //   lineWidth: 2,
              //   size: 15,
              // )
              LinearProgressIndicator(
                backgroundColor: Colors.transparent,
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue.shade100),
              )
                  :controller.getDrugsState.value == StateStatus.ERROR?
              Container(
                child: InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off,color: Colors.red,size: 40,),
                      Text('Error receiving data'),
                      Text('Tap to retry'),
                    ],
                  ),
                  onTap: (){
                    controller.getDrugs(createParameters());
                    // if(selectedIndex == 0)
                    //   controller.getDrugs("");
                    // else
                    //   controller.getDrugs(selectedUserId);
                  },
                ),
              ):
              Container(child: Center(child: Text('There is no medicine'),),)
                  :
              Container(
                margin: EdgeInsets.only(top: 5.0),
                child:
                Column(
                  children: [
                    Container(
                      height: 60,
                      child: Row(
                        children: [

                          controller.visibleSearch.value?
                          Expanded(
                            child:
                            Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: TextFormField(
                                focusNode: searchFocus,
                                controller: searchController,
                                onEditingComplete: () {
                                  page = 1;
                                  searchParams = searchController.text;
                                  controller.drugsList.clear();
                                  controller.getDrugs(createParameters());
                                },
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Get.theme.brightness == Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
                                    labelText: 'Search medicine',
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
                          ):
                          Expanded(child: Container(margin: EdgeInsets.only(left: 16.0),child: Text('Select medicine from list',style: TextStyle(fontWeight: FontWeight.bold),),)),
                          IconButton(icon: Icon(Icons.search), onPressed: (){
                            searchFocus.requestFocus();
                            controller.visibleSearch.value = true;

                          }),
                        ],),
                    ),
                    Divider(),
                    Container(height: 50,
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),
                          child: Text('Medicine',style: TextStyle(fontWeight: FontWeight.bold),),
                        ),
                        Text('Quantity',style: TextStyle(fontWeight: FontWeight.bold),)
                      ],
                    ),),
                    controller.listSize.value>0?
                    Expanded(
                      child: ListView.separated(
                          controller: _drugsScrollController,
                          itemBuilder: (context,index){
                            return
                              ListTile(
                                onTap: (){
                                  controller.drugsList[index].selected=!controller.drugsList[index].selected;
                                  controller.listSize.value++;
                                },
                                title: Row(children: [

                                  controller.drugsList[index].selected?
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: new BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.check_sharp,color: Colors.white,),
                                  ):Container( width: 30,
                                    height: 30,),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left:8.0),
                                      child: Text(controller.drugsList[index].title),
                                    ),
                                  ),
                                ],),
                                trailing: Padding(
                                  padding: const EdgeInsets.only(right:16.0),
                                  child: Text(controller.drugsList[index].quantity.toString()),
                                )

                              );
                          },
                          separatorBuilder:(context,index)=> Divider(),
                          itemCount: controller.drugsList.length
                      ),
                    ):
                    Container(child: Center(child: Text('There is no medicine'),),),
                    controller.getDrugsState.value == StateStatus.LOADING?
                        LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue.shade100),
                        )
                    // SpinKitDualRing(
                    //   color: Colors.blue,
                    //   lineWidth: 2,
                    //   size: 15,
                    // )
                        :controller.getDrugsState.value == StateStatus.ERROR&&controller.errorVisibility.value?
                    Container(
                      // height: 300,
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.wifi_off,color: Colors.red,size: 40,),
                            Text('Error receiving data'),
                            Text('Tap to retry'),
                          ],
                        ),
                        onTap: (){
                          controller.getDrugs(createParameters());
                        },
                      ),
                    ):Container(),
                    Divider(),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          FlatButton(onPressed: (){
                            Get.back();
                          }, child: Text('Cancel')),
                          FlatButton(onPressed: (){
                            for(Drug item in controller.drugsList)
                              if(item.selected)
                                controller.addItem(item.title, item.quantity.toString(),editOrder);
                            Get.back();
                          }, child: Text('Ok')),
                        ],),
                    )
                  ],
                ),
              )
          ));
      },
    );
  }
  Widget orders(){
    List<Widget> list = [];
    for(var item in controller.medicineList)
      list.add(Container(margin:EdgeInsets.only(bottom: 5.0),child: item,));
    return Column(children: list,);
  }

  addMedicine(MedicineWidget medicineWidget){
    Get.focusScope.unfocus();
    final _formKey = GlobalKey<FormState>();
    FocusNode focusNode = FocusNode();
    TextEditingController medicineController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    if(medicineWidget != null) {
      medicineController.text = medicineWidget.title;
      quantityController.text = medicineWidget.quantity;
    }
    Get.bottomSheet(
        Form(
          key: _formKey,
          child: Container(
            color: Get.theme.scaffoldBackgroundColor,
            padding: EdgeInsets.all(16.0),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      controller: medicineController,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        // Get.focusScope.requestFocus(focusNode);
                        FocusScope.of(Get.context).requestFocus(focusNode);
                        // Get.focusScope.requestFocus(quantityFocus);
                      },
                      decoration: InputDecoration(
                        labelText: 'Medicine'.tr,
                      ),
                      validator: (value){
                        if(value.isEmpty){
                          return 'Medicine title is required'.tr;
                        }
                        else return null;
                      },
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      focusNode: focusNode,
                      controller: quantityController,
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if(value.isEmpty){
                          return 'Quantity is required'.tr;
                        }
                        else return null;
                      },
                      onEditingComplete: () {
                       if(_formKey.currentState.validate()){
                         if(medicineWidget == null)
                          controller.addItem(medicineController.text, quantityController.text,editOrder);
                         else
                           controller.editItem(medicineWidget, medicineController.text, quantityController.text, editOrder);
                         Get.back();
                       }
                      },
                      decoration: InputDecoration(
                        labelText: 'Quantity'.tr,
                        // border: const OutlineInputBorder()
                      ),
                    ),
                    // SizedBox(height: 15,)
                  ],
            ),
          ),
        ));
    // showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true,
    //     builder: (context) => Padding(
    //       padding: const EdgeInsets.symmetric(horizontal:18 ),
    //       child:
    //       Padding(
    //         padding: EdgeInsets.only(
    //             bottom: MediaQuery.of(context).viewInsets.bottom),
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisSize: MainAxisSize.min,
    //           children: <Widget>[
    //                 TextFormField(
    //                   controller: medicineController,
    //                   onEditingComplete: () {
    //                     FocusScope.of(context).requestFocus(quantityFocus);
    //                   },
    //                   decoration: InputDecoration(
    //                     labelText: 'Medicine'.tr,
    //                   ),
    //                 ),
    //             SizedBox(height: 15,),
    //             TextFormField(
    //               focusNode: quantityFocus,
    //               controller: quantityController,
    //               keyboardType: TextInputType.number,
    //               onEditingComplete: () {
    //                 controller.addItem(medicineController.text, quantityController.text,null);
    //                 Get.back();
    //               },
    //               decoration: InputDecoration(
    //                 labelText: 'Quantity'.tr,
    //                 // border: const OutlineInputBorder()
    //               ),
    //             ),
    //             SizedBox(height: 15,)
    //           ],
    //         ),
    //       ),
    //
    //       // Column(
    //       //   crossAxisAlignment: CrossAxisAlignment.start,
    //       //   mainAxisSize: MainAxisSize.min,
    //       //   children: <Widget>[
    //       //     TextFormField(
    //       //       controller: medicineController,
    //       //       onEditingComplete: () => node.nextFocus(),
    //       //       decoration: InputDecoration(
    //       //         labelText: 'Medicine'.tr,
    //       //       ),
    //       //     ),
    //       //     SizedBox(height: 15,),
    //       //     TextFormField(
    //       //       controller: quantityController,
    //       //       keyboardType: TextInputType.number,
    //       //       onEditingComplete: () => node.nextFocus(),
    //       //       decoration: InputDecoration(
    //       //         labelText: 'Quantity'.tr,
    //       //         // border: const OutlineInputBorder()
    //       //       ),
    //       //     ),
    //       //     SizedBox(height: 15,),
    //       //     RaisedButton(
    //       //         shape: RoundedRectangleBorder(
    //       //           borderRadius: BorderRadius.circular(5.0),
    //       //           // side: BorderSide(color: Colors.grey.shade200)
    //       //         ),
    //       //         // color: Colors.blueGrey,
    //       //         // padding: EdgeInsets.only(top: 20,bottom: 20),
    //       //         onPressed:() {
    //       //           controller.addItem(medicineController.text, quantityController.text);
    //       //           Get.back();
    //       //         },
    //       //         child: Container(margin:EdgeInsets.only(top:20,bottom: 20),child: Text('Add'))
    //       //     ),
    //       //   ],
    //       // ),
    //     ));
  }
  editOrder(MedicineWidget medicineItem){
    addMedicine(medicineItem);
  }


}
class MedicineToPost{
  String title;
  String quantity;
  MedicineToPost({
    this.title,
    this.quantity});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    return data;
  }
}





























// DefaultTabController(
//   length: 2,
//   child: Scaffold(
//       appBar:
//       PreferredSize(
//         preferredSize: Size.fromHeight(50.0),
//         child: TabBar(
//           indicatorColor: Colors.orange,
//           labelColor: Colors.black,
//           unselectedLabelColor: Colors.grey,
//           tabs: <Widget>[
//             Tab(text: "Repeat Prescription",),
//             Tab(text: "Repeat History",),
//           ],
//         ),
//       ),
//       // AppBar(
//       //   // backgroundColor: Colors.whi,
//       //   flexibleSpace: SafeArea(
//       //     child: TabBar(
//       //       tabs: [
//       //         Tab(icon: Icon(Icons.directions_car)),
//       //         Tab(icon: Icon(Icons.directions_transit)),
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: TabBarView(
//           children: [
//             RepeatPrescription(),
//             Icon(Icons.directions_transit),
//           ],
//         ),
//       )
//   ),
// );
