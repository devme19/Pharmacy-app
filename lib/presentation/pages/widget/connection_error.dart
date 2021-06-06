import 'package:get/get.dart';

import 'package:flutter/material.dart';
class ConnectionError extends StatelessWidget {
  final ValueChanged<bool> parentAction;
  ConnectionError({this.parentAction});
  @override
  Widget build(BuildContext context) {
    return
         Center(child:
         Container(
           // color: Colors.blueGrey,
             height: 150,
             width: 200,
             child:
             Column(
               children: [
                 Expanded(flex:1,child:
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     InkWell(child: Icon(Icons.wifi_off,color: Colors.redAccent,size: 60,),
                     onTap: (){
                       parentAction(true);
                     },)
                     // IconButton(icon: Icon(Icons.wifi_off,color: Colors.redAccent,size: 50,),
                     //   onPressed: (){
                     //     // ignore: unnecessary_statements
                     //     parentAction(true);
                     //   },),
                   ],
                 )),
                 Expanded(flex:1,child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Connection Failed'.tr,),
                   ],
                 ))
               ],
             )),);
  }
}
