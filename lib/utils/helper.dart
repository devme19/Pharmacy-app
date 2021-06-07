import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:get/get.dart';

errorAction(ServerFailure failure){
  MyAlertDialog.show(failure.errorMessage, true,null,null);
}
class Item{
  String title;
  String id;
  String gender;
  Item({this.title,this.id,this.gender});
}
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
class DashboardItems{
  List<DItem> items = new List();
  DItem menuItem;
  List<String> menu = ['Total Orders','Pending Orders','Dispatch Orders','Dependents'];
  List<SvgPicture> icons = [
    SvgPicture.asset("asset/images/prescription.svg",width: 20,height: 20,color: Get.theme.brightness == Brightness.light?Get.theme.primaryColor:Colors.white,),
    SvgPicture.asset("asset/images/pending.svg",width: 20,height: 20,color: Get.theme.brightness == Brightness.light?Get.theme.primaryColor:Colors.white,),
    SvgPicture.asset("asset/images/truck.svg",width: 20,height: 20,color: Get.theme.brightness == Brightness.light?Get.theme.primaryColor:Colors.white,),
    SvgPicture.asset("asset/images/group.svg",width: 20,height: 20,color: Get.theme.brightness == Brightness.light?Get.theme.primaryColor:Colors.white,),
  ];
  List<DItem> getItems(){
    for(int i=0; i<menu.length; i++)
    {
      menuItem = new DItem(title: menu[i],icon: icons[i]);
      items.add(menuItem);
    }
    return items;
  }

}
class DItem{
  String title;
  SvgPicture icon;
  DItem({this.title,this.icon});
}