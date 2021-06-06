import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/utils/helper.dart';
class MedicineWidget extends StatelessWidget {
  // TextEditingController medicineController = TextEditingController();
  // TextEditingController quantityController = TextEditingController();
  ValueChanged<MedicineWidget> removeAction;
  ValueChanged<MedicineWidget> editAction;
  String title,quantity;
  // Item item;
  MedicineWidget({this.removeAction,this.editAction,this.title,this.quantity});
  @override
  Widget build(BuildContext context) {
    // final node = FocusScope.of(context);
    return drugItem(title,quantity);
  }
  Widget drugItem(String title,String quantity){
    return
      Container(
      height: 70,
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
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              Expanded(flex:3,child: Padding(
                padding: const EdgeInsets.only(left:16.0),
                child: AutoSizeText(title),
              )),
              Expanded(flex:2,child: AutoSizeText(quantity,textAlign: TextAlign.center,)),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Expanded(
              child: InkWell(
                onTap: (){
                  // parentAction(this);
                  removeAction(this);
                },
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red.withAlpha(150),
                              // Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle
                          ),
                          child: Center(child: Icon(Icons.delete_outline_outlined,color: Colors.white,))
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8,),
            Expanded(
              child: InkWell(
                onTap: (){
                  editAction(this);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.green.withAlpha(150),
                              // Colors.red.withOpacity(0.1),
                              shape: BoxShape.circle
                          ),
                          child: Center(child: Icon(Icons.edit_outlined,color: Colors.white,))
                      ),
                    ),
                  ],
                ),
              ),
            ),
              SizedBox(width: 8,),
          ],),
        ),
      ],),
    );
  }
}
