import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:navid_app/presentation/controllers/eps_nomination_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/utils/state_status.dart';
class PayWidget extends GetView<UserController> {
  ValueChanged<List> parentAction;
  PayWidget({this.parentAction}){
    if(controller.reasons.length == 0)
      controller.getReasons();
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        backgroundColor: Get.theme.brightness== Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
        body:
        Obx(()=>controller.getReasonState.value == StateStatus.LOADING?
        Center(
          child: SpinKitDualRing(
            color: Colors.blue,
            lineWidth: 2,
            size: 15,
          ),
        ):controller.getReasonState.value == StateStatus.SUCCESS?
        ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount:controller.reasons.length,
            itemBuilder:(context,index){
              return ListTile(
                onTap: (){
                  parentAction([controller.reasons[index].id,controller.reasons[index].title]);
                },
                title: Text(controller.reasons[index].title),
              );
            }):controller.getReasonState.value == StateStatus.ERROR?
        Center(
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
              controller.getReasons();
            },
          ),
        ):Container()
        )
      );
  }
}
