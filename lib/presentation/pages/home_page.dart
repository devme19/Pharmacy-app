import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/presentation/controllers/dashboard_controller.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navid_app/presentation/controllers/main_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/group_check_box.dart';
import 'package:navid_app/utils/helper.dart';
class HomePage extends GetView<HomeController>{
  // int selectedIndex = 0;
  // selectedAccount(int index){
  //   selectedIndex = index;
  //   userController.setAccountName(userController.accounts[index].name+" "+userController.accounts[index].family);
  //   Get.back();
  // }
  // accountsWidget(context){
  //   List<Item> items = new List();
  //   for(var user in userController.accounts){
  //     items.add(Item(title: user.name+" "+user.family,id: user.id.toString()));
  //   }
  //   showMaterialModalBottomSheet(
  //     context: context,
  //     builder: (context) => Container(height: 200,child:
  //     GroupCheckBox(
  //       title: "Select An Account",
  //       parentAction: selectedAccount,
  //       checkedIndex: selectedIndex,
  //       items: items,
  //     )
  //       ,),
  //   );
  // }
  HomePage(){
    controller.getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    controller.onMenuTapped(0);
    return Scaffold(
      appBar: AppBar(
        title:Obx(()=>Text(controller.title.value)) ,
        actions: [
          Container(
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Get.theme.primaryColor,
        foregroundColor: Colors.white,
        child: Text('Order Now',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        onPressed: () {
          controller.onMenuTapped(2);
        },
        //params
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:
      BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child:
        Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: ()=>controller.onMenuTapped(3),
                child: Column(
                  children: [
                    Expanded(flex:3,child: SvgPicture.asset("asset/images/file.svg",color:Theme.of(context).accentColor,width: 25,height: 25,)),
                    Expanded(flex:2,child: Text("History".tr),)
                  ],
                ),
              ),
              InkWell(
                onTap: ()=>controller.onMenuTapped(4),
                child: Column(
                  children: [

                    Expanded(flex:3,child: SvgPicture.asset("asset/images/group.svg",color:Theme.of(context).accentColor,width: 25,height: 25,)),
                    Expanded(flex:2,child: Text("My Dependents".tr),)
                  ],
                ),
              ),
            ],
          ),
          // child: BottomNavigationBar(
          //
          //   items: [
          //     BottomNavigationBarItem(icon: Image.asset("asset/images/1.png",width: 30,height: 30,),label: "Add Customer",),
          //     BottomNavigationBarItem(icon:  Image.asset("asset/images/2.png",width: 30,height: 30,),label: "Add Invoice"),
          //   ],
          // ),
        ),
        //other params
        //other params
      ),
      body: Obx(()=>controller.body.value),
      drawer: Drawer(
          child:
          Obx(()=>
              ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child:
                    Column(
                      children: [
                        Row(
                          children: [

                            Expanded(
                              flex:1,
                              child: Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                    color: Get.theme.accentColor.withAlpha(100),
                                    // border: Border.all(color: Colors.blueAccent)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child:
                                  controller.userInfo.value.gender!=null?
                                  Image(image: AssetImage(
                                      controller.userInfo.value.gender == "Male"?
                                      'asset/images/male.png':
                                      controller.userInfo.value.gender == "Female"?
                                      'asset/images/female.png':
                                      controller.userInfo.value.gender == "Other"?
                                      'asset/images/other.png':'asset/images/user.png'

                                  )):Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: SvgPicture.asset("asset/images/user.svg",color: Colors.white,),
                                  )
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(controller.accountName.value,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: AutoSizeText(controller.userInfo.value.email??'',maxLines: 1,style: TextStyle(color: Colors.grey.shade400),)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Icon(Icons.account_circle_sharp,color: Colors.white,size: 80,),
                          ],
                        ),

                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(200),
                    ),
                  ),
                  // Container(
                  //   // color: controller.selectedIndex.value == 0?Colors.grey.shade200:Colors.transparent,
                  //   child: ListTile(
                  //     leading: SvgPicture.asset("asset/images/dashboard.svg",color:  controller.selectedIndex.value == 0?Colors.redAccent.shade100:Colors.blue.shade400,),
                  //     title: Text('Dashboard'),
                  //     onTap: () {
                  //       Navigator.pop(context);
                  //       controller.onMenuTapped(0);
                  //     },
                  //   ),
                  // ),
                  Container(
                    // color: controller.selectedIndex.value == 1?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/user.svg",color:Theme.of(context).accentColor,width: 25,height: 25,),
                      title: Text('Edit Profile'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(1);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 2?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/prescription.svg",color:Theme.of(context).accentColor,width: 25,height: 25,),
                      title: Text('Request Prescription'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(2);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 1?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/file.svg",color:Theme.of(context).accentColor,width: 25,height: 25,),
                      title: Text('Order History'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(3);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 3?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/group.svg",color:Theme.of(context).accentColor,width: 25,height: 25,),
                      title: Text('My Dependents'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(4);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 4?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/settings.svg",color: Theme.of(context).accentColor,width: 25,height: 25),
                      title: Text('Settings'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(5);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 5?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/lock.svg",color: Theme.of(context).accentColor,width: 25,height: 25),
                      title: Text('Change Password'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(6);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 5?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/contact.svg",color: Theme.of(context).accentColor,width: 25,height: 25),
                      title: Text('Contact Us'),
                      onTap: () {
                        Navigator.pop(context);
                        controller.onMenuTapped(7);
                      },
                    ),
                  ),
                  Divider(),
                  Container(
                    // color: controller.selectedIndex.value == 6?Colors.grey.shade200:Colors.transparent,
                    child: ListTile(
                      leading: SvgPicture.asset("asset/images/exit.svg",color: Theme.of(context).accentColor,width: 25,height: 25),
                      title: Text('LogOut'),
                      onTap: () {
                        Navigator.pop(context);
                        MainController mainController = Get.find();
                        mainController.logOut();
                        Get.offAndToNamed(NavidAppRoutes.loginPage);
                      },
                    ),
                  ),
                ],
              ),
          )
      ),
    );
  }

}