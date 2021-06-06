import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/presentation/controllers/history_controller.dart';
import 'package:navid_app/presentation/controllers/init_controller.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/group_check_box.dart';
import 'package:navid_app/presentation/pages/widget/history_item.dart';
import 'package:navid_app/utils/filter.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

import 'widget/connection_error.dart';
class HistoryPage extends GetView<HistoryController> {
  int pageIndex=1;
  String parameters,filterParameters="";
  String userAccountInfo ="";
  InitController initController;
  Filter filter;
  int dependencyId;
  bool isDashboard = false;
  ScrollController _scrollController = ScrollController();

  int selectedIndex;

  TextEditingController nameEditController = TextEditingController();

  List<Item> items;

  SettingController settingController = Get.put(SettingController());

  HistoryPage(){
    pageIndex = 1;
    parameters = "?page=$pageIndex&pagesize=$pageSize";
    filterParameters = "";
    if(Get.arguments[0] is String) {
      userAccountInfo = Get.arguments[0];
      if(Get.arguments[1] != null)
      {
        filter = Get.arguments[1];
        switch(filter){
          case Filter.ALL:
            filterParameters = "";
            break;
          case Filter.PENDING:
            filterParameters = "&status_id=4";
            break;
          case Filter.DELIVERED:
            filterParameters = "&status_id=10";
            break;
        }
      }
    } else
    if(Get.arguments[0] is int) {
      dependencyId = Get.arguments[0];
      filterParameters = '&dependency_id=$dependencyId';
      isDashboard = true;
    }
    controller.getOrders(parameters+filterParameters);
    initController = Get.put(InitController());
    initController.getStatusList(false);
    _scrollController.addListener(_scrollListener);
  }
  _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if(controller.orders.length !=0)
        pageIndex = controller.pageIndex+1;
      parameters = "?page=${pageIndex}&pagesize=$pageSize";
      controller.getOrders(parameters+filterParameters);
    }
  }
  showFilter(context){
    items =[];
    for(var item in initController.statusEntity.value.data)
      items.add(Item(title: item.title,id: item.id.toString()));
    // for(var user in controller.accounts){
    //   items.add(Item(title: user.name+" "+user.family,id: user.id.toString()));
    // }
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: Get.theme.brightness==Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
        height: 500,child:
      Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (){
                    pageIndex = 1;
                    controller.orders.clear();
                    nameEditController.clear();
                    selectedIndex = -1;
                    filterParameters = "";
                    parameters = '?page=${pageIndex}&pagesize=$pageSize';
                    if(isDashboard)
                      parameters += '&dependency_id=${dependencyId}';
                    controller.getOrders(parameters);
                    Get.back();
                  },
                  child: Row(children: [

                    Text('Clear filter'),
                    Icon(Icons.clear),
                  ],),
                ),
              ),
            ],
          ),
          isDashboard?
          Container():
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Expanded(flex:1,child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:16.0),
                        child: Text("Filter by name or last name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: settingController.fontSize.value+3),),
                      ),
                    ],
                  )),
                  SizedBox(height: 5,),
                  Container(
                    // height: 50,
                    padding: EdgeInsets.all(16.0),
                    child: TextFormField(
                      controller: nameEditController,
                      onEditingComplete: (){
                        pageIndex = 1;
                        controller.orders.clear();
                        filterParameters = "&name="+nameEditController.text;
                        controller.getOrders("?page=${pageIndex}&pagesize=$pageSize"+filterParameters);
                        Get.back();
                      },
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.email),
                          labelText: 'Name'.tr,
                          border: const OutlineInputBorder()
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Expanded(flex:1,child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: Text("Filter by status",style: TextStyle(fontWeight: FontWeight.bold,fontSize: settingController.fontSize.value+3),),
              ),
            ],
          )),

          Expanded(
            flex: 11,
            child: GroupCheckBox(
              title: "Filter by",
              parentAction: selectedFilter,
              checkedIndex: selectedIndex,
              items: items,
            ),
          ),
        ],
      )
        ,),
    );
  }
  selectedFilter(int index){
    selectedIndex = index;
    pageIndex = 1;
    controller.orders.clear();
    filterParameters = "&status_id=${items[index].id}";
    controller.getOrders("?page=${pageIndex}&pagesize=$pageSize"+filterParameters);
    Get.back();
  }
  _onPressConnectionError(bool refresh){
    _refresh();
  }

  Future _refresh()async{
    pageIndex = 1;
    controller.orders.clear();
    controller.getOrders("?page=${pageIndex}&pagesize=$pageSize");
  }
  updateItem(String id){
    _refresh();
  }
  removeItem(String id){
    controller.orders.remove(controller.orders.singleWhere((i) => i.id.toString() == id));
    controller.isDeleted.value++;
    // widget.controller.deleteOrder(id);
    // // pageIndex = 1;
    // controller.orders.clear();
    // controller.getOrders("?page=$pageIndex&pagesize=$pageSize");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor:Get.theme.primaryColor,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
          onPressed: () {
            Get.toNamed(NavidAppRoutes.prescriptionPage,arguments: [null,false,null,null]).then((value) {
              controller.orders.clear();
              controller.getOrders("?page=1&pagesize=$pageSize" + filterParameters);
            });
          },
          //params
        ),
        appBar: AppBar(
            title: Text("Order History"),
            actions: [
              IconButton(
                onPressed: (){
                  showFilter(context);
                },
                icon: Icon(Icons.filter_alt_outlined),
              ),

            ]
        ),
        body:
        RefreshIndicator(
          onRefresh: _refresh,
          child: view(),
        )
    );
  }
  Widget view(){
    return Column(
      children: [
        Expanded(
          flex: 1,
          child:
          Container(
              padding: EdgeInsets.all(16),
              child:
              Obx(()=>
              controller.orders.length != 0 || controller.isDeleted.value>0?
              controller.orders.length == 0?Center(child: Text("There is no order".tr),):Column(
                children: [
                  // Expanded(child:
                  //     SingleChildScrollView(
                  //         controller: _scrollController,
                  //         child: createListCard())
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: controller.orders.length,
                      itemBuilder: (context,index){
                        return
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 0.0,bottom:32.0),
                              child: HistoryItem(order: controller.orders[index],parentRemoveAction: removeItem,parentUpdateAction: updateItem,userAccountInfo: userAccountInfo,),
                            ),
                          );
                      },),
                  ),
                  controller.getOrdersStatus.value == StateStatus.LOADING?
                  Container(
                    child: SpinKitDualRing(
                      color: Colors.blue,
                      lineWidth: 2,
                      size: 15,
                    ),
                  ):Container()
                ],
              ):
              controller.getOrdersStatus.value == StateStatus.LOADING?
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: SpinKitDualRing(
                    color: Colors.blue,
                    lineWidth: 2,
                  ),
                ),
              ):controller.getOrdersStatus.value == StateStatus.ERROR?
              ConnectionError(parentAction: _onPressConnectionError,):
              Center(child: Text("There is no order".tr),),

                // (controller.getOrdersStatus.value == StateStatus.LOADING)?
                //     SpinKitDualRing(color: Colors.blue):
                //     controller.getOrdersStatus.value == StateStatus.SUCCESS?
                //         controller.orders.length!=0?
                //             ListView.builder(
                //               controller: _scrollController,
                //               itemCount: controller.orders.length,
                //               itemBuilder: (context,index){
                //               return
                //                 Padding(
                //                   padding: const EdgeInsets.only(top: 0.0,bottom:32.0),
                //                   child: HistoryItem(order: controller.orders[index],),
                //                 );
                //             },):
                //         Container(child: Center(child: Text("There is no order")),):Container()
              )

          ),
        ),
      ],
    );
  }
}