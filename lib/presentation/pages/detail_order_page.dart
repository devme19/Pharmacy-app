import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/detail_order_controller.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/connection_error.dart';
import 'package:navid_app/presentation/pages/widget/drugs_widget.dart';
import 'package:navid_app/utils/detail_order_painter.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';
class DetailOrderPage extends GetView<DetailOrderController> {
  String id;
  bool isAdd = false;
  SettingController settingController = Get.put(SettingController());
  ValueChanged<String> parentAction;
  ValueChanged<String> parentUpdate;
  DetailOrderPage(){
    id = Get.arguments[0];
    isAdd = Get.arguments[1];
    if(Get.arguments[2] != null)
      parentAction = Get.arguments[2];
    if(Get.arguments[3] != null)
      parentUpdate = Get.arguments[3];
    controller.getDetailOrder(id);
  }
  double radius = 10;
  updateOrder(String id) {
    controller.getDetailOrder(id);
    parentUpdate(id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prescription Detail"),
        actions: [
          Container(
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
      body:Obx(()=>
      controller.getDetailOrderState.value == StateStatus.LOADING?
      SpinKitDualRing(color: Colors.blue,lineWidth: 2,):
      controller.getDetailOrderState.value == StateStatus.SUCCESS?
      Container(
        // margin: EdgeInsets.only(top: Get.height/8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child:
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(25),
                            margin: EdgeInsets.only(bottom: 16),
                            child:
                            Center(
                              child: Text(controller.detailOrder.value.data.status.title,
                                style: TextStyle(color: Colors.white),),
                            ),
                            decoration: BoxDecoration(
                                // boxShadow: [
                                //   Get.theme.brightness==Brightness.light? BoxShadow(
                                //     color: Colors.blueGrey.shade100,
                                //     spreadRadius: 1,
                                //     blurRadius:5,
                                //     // Get.theme.brightness == Brightness.light? 15:5,
                                //     offset: Offset(0, 1), // changes position of shadow
                                //   ):BoxShadow(
                                //     color: Colors.blueGrey.shade100,
                                //     spreadRadius: 0,
                                //     blurRadius:0,
                                //     // Get.theme.brightness == Brightness.light? 15:5,
                                //     offset: Offset(0, 0), // changes position of shadow
                                //   ),
                                // ],
                                color:hexToColor(controller.detailOrder.value.data.status.color).withOpacity(0.6),
                                borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Card(child: order()),
                    // Card(child: buyer()),
                    person("Patient",controller.detailOrder.value.buyer.name+" "+controller.detailOrder.value.buyer.family,
                        controller.detailOrder.value.buyer.phone,
                        controller.detailOrder.value.buyer.address
                    ),
                    person("Newport Pharmacy","",
                        controller.detailOrder.value.seler.phone,
                        controller.detailOrder.value.seler.address
                    ),
                    order(),

                  ],
                ),
              ),
            ),
            controller.detailOrder.value.data.status_id == 3 && !isAdd?
            Row(
              children: [
                Expanded(
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadius),
                        // side: BorderSide(color: Colors.grey.shade200)
                      ),
                      // padding: EdgeInsets.only(top: 20,bottom: 20),
                      onPressed:() {
                        Get.toNamed(NavidAppRoutes.prescriptionPage,arguments: [controller.detailOrder.value.data,false,parentAction,updateOrder]);
                      },
                      child: Container(margin:EdgeInsets.only(top:20,bottom: 20),child: Text("Edit Order"))
                  ),
                ),
              ],
            ):Container(),
          ],),
        ),
      ):
      controller.getDetailOrderState.value == StateStatus.ERROR?
      ConnectionError(parentAction: onTapConnectionError,):
      Container())

    );
  }
  onTapConnectionError(bool refresh){
    controller.getDetailOrder(id);
  }
  Widget person(String title,String name,String phone,String address){
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.only(bottom:16.0),
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
      child: Column(children: [
        Container(
          height: 50,
          // color: Colors.blueGrey.withAlpha(25),
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(child: AutoSizeText(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: settingController.fontSize.value+4),)),
              Expanded(child: AutoSizeText(name)),
            ],
          ),
        ),
        item('Phone Number',phone,false),
        item('Address',address,false),
        // item('Address',controller.detailOrder.value.buyer.address,controller.detailOrder.value.seler.address+"hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh",true),
      ],),
    );
  }
  Widget order(){
    return
      Column(
        children: [
          Container(
          // padding: EdgeInsets.all(16.0),
      // margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color:Get.theme.brightness == Brightness.light? Colors.white:Colors.grey.shade800,
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
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
    ],),
              child: DrugsWidget(order: controller.detailOrder.value.data,)),
        ],
      );

  }
  Widget item(String title,String value1,bool alpha){
    return Container(
      color: alpha?Colors.grey.withAlpha(15):Colors.grey.withAlpha(5),
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: AutoSizeText(title,style: TextStyle(fontWeight: FontWeight.bold),)),
          Expanded(child: AutoSizeText(value1??'',maxLines: 10,)),
        ],
      ),
    );
  }
}
