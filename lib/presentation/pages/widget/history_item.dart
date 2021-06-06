import 'dart:convert';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/presentation/controllers/history_controller.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/prescription_page.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:get/get.dart';
import 'package:navid_app/utils/state_status.dart';

import 'drugs_widget.dart';

class HistoryItem extends StatefulWidget {

  Data order;
  ValueChanged<String> parentRemoveAction;
  ValueChanged<String> parentUpdateAction;
  String userAccountInfo;
  String dateStr;
  HistoryItem({this.order,this.parentRemoveAction,this.parentUpdateAction,this.userAccountInfo}){
    dateStr = order.created_at.substring(8,10)+'-'+order.created_at.substring(5,7)+'-' +order.created_at.substring(0,4);
  }

  @override
  _HistoryItemState createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem>{
  SettingController settingController = Get.put(SettingController());
  HistoryController historyController = Get.put(HistoryController());
  double containerHeight = 20;
  double radius = 10;


  @override
  Widget build(BuildContext context) {
    return
      Obx(()=>AnimatedOpacity(
        opacity: widget.order.deleted.value?0.0:1.0,
        duration: Duration(milliseconds: 4000),
        child: Container(
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
          // decoration: BoxDecoration(
          //     color: Get.theme.brightness == Brightness.light?
          //     Colors.white:Colors.black12,
          //     borderRadius: BorderRadius.all(Radius.circular(radius))
          // ),
          // height:widget.order.isExpanded? settingController.historyItemHeight+500:settingController.historyItemHeight,
          child:
          Column(
            children: [
              Container(
                  height: 60,
                  child: statusWidget(hexToColor(widget.order.status.color), widget.order.status.title)),
              Container(
                child: Column(children: [
                  Container(
                    height: 45,
                    margin: EdgeInsets.only(top: 20,left: 16,right: 16),
                    child: Row(
                      children: [
                        Expanded(flex:1,child: AutoSizeText(widget.dateStr,maxLines: 1)),
                        Expanded(
                          flex: 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // widget.order.status.id == 10?
                              // Expanded(
                              //   child:
                              //   InkWell(
                              //     onTap: (){
                              //       Get.toNamed(NavidAppRoutes.prescriptionPage,arguments: [widget.order,true]).then((value) => widget.parentAction(true));
                              //     },
                              //     child: Container(
                              //       padding: EdgeInsets.all(9.0),
                              //       child: Center(child: AutoSizeText("Re-Order",maxLines: 1,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                              //       decoration: BoxDecoration(
                              //         color: Color(0xff1bc383),
                              //           borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                              //           border: Border.all(color: Color(0xff1bc383))
                              //       ),
                              //     ),
                              //   ),
                              // ):Container(),
                              // SizedBox(width: 10,),
                              Expanded(
                                child:
                                InkWell(
                                  onTap: (){
                                    // if(widget.order.status_id == 3)
                                    //   Get.toNamed(NavidAppRoutes.prescriptionPage,arguments: [widget.order,false]).then((value) {
                                    //     widget.parentAction(true);
                                    //   });
                                    // else
                                    Get.toNamed(NavidAppRoutes.detailOrderPage,arguments: [widget.order.id.toString(),false,widget.parentRemoveAction,widget.parentUpdateAction]);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(9.0),
                                    child: Center(child: AutoSizeText("View Detail",maxLines: 1,style: TextStyle(color: Color(0xff1bc383)),textAlign: TextAlign.center,)),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                                        border: Border.all(color: Color(0xff1bc383))
                                    ),
                                  ),
                                ),
                              ),
                            ],),
                        )
                      ],),
                  ),
                  // Expanded(
                  //   flex: 2,
                  //   child: Container(
                  //     height: 45,
                  //     child: ListView.builder(
                  //         itemCount: order.orderlist.length,
                  //         scrollDirection:Axis.horizontal ,
                  //         itemBuilder: (context,index){
                  //           return Padding(
                  //             padding: const EdgeInsets.only(right:8.0),
                  //             child: drugWidget(order.orderlist[index].title, order.orderlist[index].quantity.toString()),
                  //           );
                  //         }),
                  //   ),
                  // ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height:90,
                          // color:Colors.red,
                          child: ExpandIcon(
                            isExpanded: widget.order.isExpanded,
                            color: Colors.grey,
                            expandedColor: Colors.grey,
                            onPressed: (bool isExpanded) {
                              setState(() {
                                widget.order.isExpanded = !widget.order.isExpanded;
                              });
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                  widget.order.isExpanded?Container(
                    // margin: EdgeInsets.only(top: 0),
                      child: DrugsWidget(order: widget.order)
                    // Column(children: createDrugsList(),)
                    // ListView.builder(
                    //           itemCount: widget.order.orderlist.length,
                    //           // scrollDirection:Axis.horizontal ,
                    //           itemBuilder: (context,index){
                    //             return Padding(
                    //               padding: const EdgeInsets.only(right:8.0),
                    //               child: drugWidget(widget.order.orderlist[index].title, widget.order.orderlist[index].quantity.toString()),
                    //             );
                    //           }),
                  ):Container(),
                ],),
              )
            ],
          ),
        ),
      ));
  }

  setHeight(double height){
    setState(() {
      containerHeight = height;
    });
  }
  setReorder(int state){
    setState(() {
      widget.order.reorder = state;
    });
  }
  Widget statusWidget(Color color,String title){
    return
      Container(

      decoration: BoxDecoration(
          color: color.withAlpha(25),
          borderRadius: BorderRadius.only(topLeft:Radius.circular(borderRadius),topRight:Radius.circular(borderRadius))
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(child:
          Row(

            children: [
              Expanded(child: AutoSizeText(title,style: TextStyle(color: color,fontWeight: FontWeight.bold),maxLines: 2,textAlign: TextAlign.start,)),
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AutoSizeText( widget.order.family != null?widget.order.family.name+" "+widget.order.family.family:widget.userAccountInfo,maxLines: 2,style: TextStyle(color: color),),
            ],
          )
        ],
      ),
    );
  }
  List<Widget> createDrugsList(){
    List<Widget> list = new List();
    list.add(Row(
      children: [
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText("Title",style: TextStyle(fontWeight: FontWeight.bold),),
        )),
        Expanded(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoSizeText("Quantity",textAlign: TextAlign.end,style: TextStyle(fontWeight: FontWeight.bold)),
        ))
      ],
    ),);
    for(var item in widget.order.orderlist)
      list.add(drugWidget(item.title, item.quantity.toString()));
    return list;
  }
  Widget drugWidget(String title,String quantity){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(0.0),
          child: Row(
            children: [
              Expanded(flex:2,child: AutoSizeText(title)),
              Expanded(flex:1,child: AutoSizeText(quantity,textAlign: TextAlign.end,))
            ],
          ),
        )
      ],
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



