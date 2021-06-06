import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
class DrugsWidget extends StatelessWidget {
  Data order;
  // final ValueChanged<double> height;
  GlobalKey widgetKey = GlobalKey();
  DrugsWidget({this.order});
  SettingController settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    // SchedulerBinding.instance.addPostFrameCallback(postFrameCallback);
    return Container(
        key: widgetKey,
        child: Padding(
          padding: const EdgeInsets.only(top:8.0,left: 8.0,right: 8.0,bottom: 32.0),
          child: Column(children: createDrugsList()),
        ));
  }
  // void postFrameCallback(_) {
  //   RenderBox context = widgetKey.currentContext.findRenderObject();
  //   if (context == null) return;
  //
  //   var size = context.size;
  //   print(size.height.toString()+"  "+size.width.toString());
  //   height(size.height);
  // }
  List<Widget> createDrugsList(){
    List<Widget> list = new List();
    list.add(Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: AutoSizeText("Medicine",style: TextStyle(fontWeight: FontWeight.bold,fontSize: settingController.fontSize.value+3)),
          )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: AutoSizeText("Quantity",textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold,fontSize: settingController.fontSize.value+3)),
          ))
        ],
      ),
    ),);
    list.add(Padding(
      padding: const EdgeInsets.only(left:16.0,right: 16.0),
      child: Divider(),
    ));
    bool alpha = true;
    for(var item in order.orderlist) {
      list.add(drugItem(
        item.title,
        item.quantity.toString(),
        alpha
      ));
      alpha = !alpha;
    }
    return list;

  }
  Widget drugItem(String title,String quantity,bool alpha){
    return Container(
      // color: alpha?Colors.grey.withAlpha(15):Colors.grey.withAlpha(5),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex:2,child: Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10.0,left: 20,right: 20),
                child: AutoSizeText(title),
              )),
              Expanded(flex:1,child: Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10.0,left: 20,right: 20),
                child: AutoSizeText(quantity,textAlign: TextAlign.end,),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left:16.0,right: 16.0),
            child: Divider(),
          )
        ],
      ),
    );

    //   Container(
    //   // padding: EdgeInsets.only(left: 16,right: 16),
    //   child: Row(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Container(child: Text(title,style: TextStyle(color: Colors.grey.shade700),)),
    //       ),
    //       Container(
    //         width: 1,
    //         color: Colors.grey.shade300,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(10.0),
    //         child: Text(quantity,style: TextStyle(color: Colors.grey.shade700)),
    //       )
    //     ],
    //   ),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.all(Radius.circular(5)),
    //     border: Border.all(color: Colors.grey.shade300,width: 1)
    //   ),
    // );
  }
}