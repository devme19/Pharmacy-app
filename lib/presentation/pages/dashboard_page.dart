import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/data/model/dashboard_model.dart';
import 'package:navid_app/presentation/controllers/dashboard_controller.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/content_widget.dart';
import 'package:navid_app/utils/filter.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';


class DashBoardPage extends GetView<DashboardController>{

  SettingController settingController = Get.put(SettingController());
  // HomeController homeController = Get.put(HomeController());
  List<DItem> dashboardItems;
  DashBoardPage(){
    dashboardItems = new DashboardItems().getItems();
    controller.getDashboard();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>Container(
        margin: EdgeInsets.all(16.0),
        child:
        ListView(
          children: [
            // SizedBox(height: 16,),
            dashboardWidget(),
            SizedBox(height: 16,),
            controller.dashboardEntity.value.family != null?
            controller.dashboardEntity.value.family.length != 0?
            Container(
                padding: EdgeInsets.only(bottom: 16,top: 16),
                decoration: BoxDecoration(
                    color:Get.theme.brightness == Brightness.light?
                    Colors.white:
                    Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius))
                ),
                child: Column(children:createDependents(),)):Container():Container()

          ],
        ),
        // Column(children: ,)
        // CustomScrollView(
        //   slivers: <Widget>[
        //     SliverToBoxAdapter(
        //       child: Container(
        //         margin: EdgeInsets.all(16.0),
        //         width: double.infinity,
        //         height: 70,
        //         decoration: BoxDecoration(
        //             color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))),
        //         child:  Container(
        //           child: Padding(
        //             padding: const EdgeInsets.only(left:32.0,top: 32),
        //             child: Text("Summary",style: TextStyle(fontSize: settingController.fontSize.value+5,fontWeight: FontWeight.bold),),
        //           ),
        //         ),
        //       ),
        //     ),
        //     SliverPadding(
        //       padding: EdgeInsets.only(left:32,right: 32),
        //       sliver:
        //       SliverGrid(
        //         gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //           maxCrossAxisExtent: 200,
        //           mainAxisSpacing: 15.0,
        //           crossAxisSpacing: 15.0,
        //           childAspectRatio: 1.0,
        //         ),
        //         delegate: SliverChildBuilderDelegate(
        //               (BuildContext context, int index) {
        //             return
        //               myDashboardItem(index);
        //           },
        //           childCount: 3,
        //         ),
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Container(
        //         margin: EdgeInsets.all(16.0),
        //         width: double.infinity,
        //         height: 70,
        //         decoration: BoxDecoration(
        //             color: Colors.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50))),
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Divider(
        //
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Container(
        //         child: Padding(
        //           padding: const EdgeInsets.only(left:16.0,top: 25,right: 16),
        //           child: Text("Dependents",style: TextStyle(fontSize: settingController.fontSize.value+5,fontWeight: FontWeight.bold),),
        //         ),
        //       ),
        //     ),
        //     SliverToBoxAdapter(
        //       child: Padding(
        //         padding: const EdgeInsets.all(12.0),
        //         child: Card(
        //           child: Column(
        //             children: createDependents(),
        //           ),
        //         ),
        //       ),
        //     )
        //
        //   ],
        // ),
      )),
    );
  }
  Widget dashboardWidget(){
    return
      Container(
      height: 500,
      decoration: BoxDecoration(
          color:Get.theme.brightness == Brightness.light?
          Colors.white:
          Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius))
      ),
      child: Column(
        children: [
          Row(children: [
            Container(
              height: 60,
              padding: EdgeInsets.only(left: 16),
              child: Center(child: Text("Summary",style: TextStyle(fontSize: settingController.fontSize.value+5,fontWeight: FontWeight.bold),)),
            ),
          ],),
          Divider(),
          Expanded(
            flex: 3,
            child:
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0,left: 8.0,right: 8.0,top: 16.0),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: myDashboardItem(0)),
                        Expanded(child: myDashboardItem(1)),
                      ],),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(child: myDashboardItem(2)),
                        Expanded(child: myDashboardItem(3)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  tap(int index){
    HomeController homeController = Get.put(HomeController());
    switch(index){
      case 0:
        Get.toNamed(NavidAppRoutes.historyPage,arguments: [homeController.accountName.value,Filter.ALL]).then((value) => ContentWidget(body: DashBoardPage()));
        break;
      case 1:
        Get.toNamed(NavidAppRoutes.historyPage,arguments: [homeController.accountName.value,Filter.PENDING]).then((value) => ContentWidget(body: DashBoardPage()));
        break;
      case 2:
        Get.toNamed(NavidAppRoutes.historyPage,arguments: [homeController.accountName.value,Filter.DELIVERED]).then((value) => ContentWidget(body: DashBoardPage()));
        break;
      case 3:
        Get.toNamed(NavidAppRoutes.myDependentsPage);
        break;
    }
  }
  Widget myDashboardItem(int index){
    return
      InkWell(
        onTap: ()=>tap(index),
        child: Container(
            margin: EdgeInsets.all(8.0),
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
            child: Container(
              // padding: const EdgeInsets.all(8.0),
              child: Column(

                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color:  Get.theme.brightness==Brightness.light?Get.theme.primaryColor.withOpacity(0.12):Colors.grey.withOpacity(0.5),
                                  // Colors.red.withOpacity(0.1),
                                  shape: BoxShape.circle
                              ),
                              child: dashboardItems[index].icon
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center
                      ,
                      children: [
                        AutoSizeText(
                            dashboard(index)
                            ,
                            maxLines: 1,
                            style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          dashboardItems[index].title,
                          maxLines: 2,
                          textAlign: TextAlign.center,

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
      );
  }
  String dashboard(int index){
    switch(index){
      case 0:
        return (controller.dashboardEntity.value.count_order ??"").toString();
      case 1:
        return (controller.dashboardEntity.value.count_pending ??"").toString();
      case 2:
        return (controller.dashboardEntity.value.count_delivered ??"").toString();
      case 3:
        return (controller.dashboardEntity.value.family!=null?controller.dashboardEntity.value.family.length :"").toString();
      default:
        return "";
    }
  }
  List<Widget> createDependents(){
    List<Widget> dependents = new List();
    bool alpha = false;
    dependents.add( Container(
      height: 60,
      padding: EdgeInsets.only(left: 16,right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Dependents",style: TextStyle(fontSize: settingController.fontSize.value+5,fontWeight: FontWeight.bold),),
          Text("Total orders",style: TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    ),);
    dependents.add( Divider());
    if(controller.dashboardEntity.value.family != null)
      for(Family family in controller.dashboardEntity.value.family) {
        dependents.add(item(family));
        alpha = !alpha;
        dependents.add( Padding(
          padding: const EdgeInsets.only(left:16.0,right: 16.0),
          child: Divider(),
        ));
      }
    return dependents;
  }
  Widget item(Family family){
    return ListTile(
      onTap: (){
        Get.toNamed(NavidAppRoutes.historyPage,arguments: [family.id]).then((value){
          dashboardItems = new DashboardItems().getItems();
          controller.getDashboard();
        });
      },
      leading: Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:Get.theme.accentColor.withAlpha(50),
            // border: Border.all(color: Colors.blueAccent)
          ),
          child: Image(image: AssetImage(
              family.gender.toLowerCase() == "male"?
              'asset/images/male.png':
              family.gender.toLowerCase() == "female"?
              'asset/images/female.png':
              family.gender.toLowerCase() == "other"?
              'asset/images/other.png':''
          ))
      ),
      title: AutoSizeText(family.name+" "+family.family,style: TextStyle(fontWeight: FontWeight.bold),),
      subtitle: AutoSizeText(family.phone??''),
      trailing: AutoSizeText(family.count_order_family.toString()),
      // Container(
      //   // height: 60,
      //   margin: EdgeInsets.only(bottom: 4,left: 16,right: 16),
      //   decoration: BoxDecoration(
      //           // boxShadow: [
      //           //   BoxShadow(
      //           //     color: Colors.blueGrey.shade100,
      //           //     spreadRadius: 0,
      //           //     blurRadius:5,
      //           //     // Get.theme.brightness == Brightness.light? 15:5,
      //           //     offset: Offset(0, 1), // changes position of shadow
      //           //   ),
      //           // ],
      //       color:Get.theme.brightness == Brightness.light? Colors.white:Colors.grey.shade800,
      //       borderRadius: BorderRadius.all(Radius.circular(10))
      //   ),
      //   padding: EdgeInsets.all(32.0),
      //   child: Row(
      //     children: [
      //       // Image(image: AssetImage(
      //       //     gender == "male"?
      //       //     'asset/images/male.png':
      //       //     gender == "female"?
      //       //     'asset/images/female.png':
      //       //     gender == "other"?
      //       //     'asset/images/other.png':''
      //       // )),
      //       Expanded(child: AutoSizeText(title,textAlign: TextAlign.start,)),
      //       Expanded(child: AutoSizeText(value,textAlign: TextAlign.end,)),
      //     ],
      //   ),
      // ),
    );
  }

}