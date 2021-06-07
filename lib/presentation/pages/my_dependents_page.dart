import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/presentation/controllers/dependents_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/connection_error.dart';
import 'package:navid_app/presentation/pages/widget/group_check_box.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';
class MyDependentsPage extends GetView<DependentsController>{
  int checkedIndex = -1;
  ValueChanged<String> user;
  MyDependentsPage({this.user}){
    controller.getMyDependents();
  }
  getUser(int id){
    Get.toNamed(NavidAppRoutes.epsNominationPage,arguments: id).then((value) {
      controller.getMyDependents();
    });
    controller.myDependents.clear();
  }
 Widget createList(List<UserEntity> dependents){
    List<Widget> list=new List();
    if(dependents.length<1)
        return Center(child: Text("You have no dependent"),);
    for(var dependent in dependents)
      list.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: item(dependent),
      ));
    return ListView(
      children: list,
    );
  }
  _onConnectionErrorTap(bool refresh){
    controller.myDependents.clear();
    controller.getMyDependents();
  }
  Widget item(UserEntity dep){
    return Container(
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
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        leading:
        Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:Get.theme.accentColor.withAlpha(50),
            // border: Border.all(color: Colors.blueAccent)
          ),
          child: Image(image: AssetImage(
              dep.gender.toLowerCase() == "male"?
              'asset/images/male.png':
              dep.gender.toLowerCase() == "female"?
              'asset/images/female.png':
              dep.gender.toLowerCase() == "other"?
              'asset/images/other.png':''
          )),
        ),
        trailing:(controller.deleteDependentsState.value == StateStatus.LOADING &&
        dep.id.toString() == controller.deletedUserId)?
        Container(
          width: 60,
          height: 60,
          child: Center(
            child: SpinKitDualRing(
              color: Colors.blue,
              lineWidth: 2,
              size: 15,
            ),
          ),
        ):InkWell(
          onTap: (){
            Get.defaultDialog(
              content: Text('Are you sure to delete?'),
              textConfirm: 'Yes',
              textCancel: 'Cancel',
              buttonColor: Colors.white,
              onConfirm: (){
                controller.deleteDependent(dep.id.toString());
                Get.back();
              },
            );
          },
            child: Container(
              width: 60,
                height: 60,
                // color: Colors.blue,
                child: Icon(Icons.delete,color: Colors.red,))),
        onTap: ()=>getUser(dep.id),
        title: Text(dep.name+" "+dep.family,style: TextStyle(fontWeight: FontWeight.bold),),
        subtitle: Text(dep.phone!=null?dep.phone:'',style: TextStyle(color: Colors.grey),),
      ),
    );
    // InkWell(child:
    // Container(
    //   height: 90,
    //   child: Card(child:
    //   Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child:
    //     Row(
    //       children: [
    //         Expanded(flex:1,child:
    //         Icon(Icons.account_circle_sharp,size: 40,)),
    //         Expanded(
    //           flex: 5,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [
    //               Row(
    //                 children: [
    //                   Text(dep.name+" "+dep.family,style: TextStyle(fontWeight: FontWeight.bold),),
    //                 ],
    //               ),
    //               // SizedBox(height: 10,),
    //               Row(
    //                 children: [
    //                   Text(dep.phone,style: TextStyle(color: Colors.grey),),
    //                 ],
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),),
    // ),
    //   onTap: ()=>getUser(dep.id),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor:Get.theme.primaryColor,
        foregroundColor: Colors.white,
        onPressed: ()
        {
            Get.toNamed(NavidAppRoutes.epsNominationPage, arguments: -1)
                .then((value) {
              controller.getMyDependents();
            });
            controller.myDependents.clear();
          },
      ),
      appBar: AppBar(
        title: Text("My Dependents"),
        actions: [
          Container(
              margin: EdgeInsets.all(8.0),
              // color: Colors.blue.withOpacity(0.1),
              child: Image.asset('asset/images/nhs.png'))
        ],
      ),
      body:
      Obx(()=>
      (controller.getDependentsState.value == StateStatus.SUCCESS||controller.listLength>-1)?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: createList(controller.myDependents),
      ):
      controller.getDependentsState.value == StateStatus.LOADING?
          SpinKitDualRing(color: Colors.blue,lineWidth: 2,):
      controller.getDependentsState.value == StateStatus.ERROR?
          ConnectionError(parentAction: _onConnectionErrorTap,):Container()
      )
    );
  }
}
