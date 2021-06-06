import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
class MyAlertDialog {

  static void show(List<String> titles,bool isAlert,ValueChanged<bool> parentAction){
    Get.defaultDialog(
        confirm:
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: ElevatedButton(
              // color: Colors.blue.shade600,
              child:
              Text('ok'.tr,textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),onPressed: (){
                Get.back();
                if(titles[0].contains('Dear')==true)
                  Get.toNamed(NavidAppRoutes.epsNominationPage).then((value) {
                    parentAction(true);
                  });

            // Get.toNamed(ZanaStorageRoutes.invoiceDetailPage,arguments: id);

          }),
        ),
        title: "",
        content: Container(
          // height: 200,
          child: Column(
            children: createContent(titles,isAlert),
          ),
        )
        // middleTextStyle: TextStyle(fontSize: 21,),
        // middleText: title
    );
  }
  static List<Widget> createContent(List<String> titles,bool isAlert){
    List<Widget> columns = [];
    for(var title in titles){
      columns.add(Row(
        mainAxisAlignment:  isAlert? MainAxisAlignment.center:MainAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0,left: 32,right: 32),
              child: isAlert?
              Text(title,textAlign:TextAlign.center,style: TextStyle(fontSize: 21,),):
              Text("- $title",style: TextStyle(fontSize: 21),),
            ),
          ),
        ],
      ));
    }
    return columns;
  }

}
