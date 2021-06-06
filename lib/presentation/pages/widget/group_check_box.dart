import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:navid_app/utils/helper.dart';
class GroupCheckBox extends StatefulWidget {
  final ValueChanged<int> parentAction;
  String title;
  List<Item> items;
  int checkedIndex;
  GroupCheckBox({this.title,this.items,this.checkedIndex,this.parentAction});
  @override
  _GroupCheckBoxState createState() => _GroupCheckBoxState();
}

class _GroupCheckBoxState extends State<GroupCheckBox> {
  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Get.theme.brightness==Brightness.light?Colors.white:Get.theme.scaffoldBackgroundColor,
        padding: EdgeInsets.all(8),
        // height: 250,
        child:
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: createItems(),),
        ),
      );
  }
  List<Widget> createItems(){
    List<Widget> list  = new List();
    for(int index=0;index<widget.items.length;index++){
      list.add(checkItem(widget.items[index].title,widget.checkedIndex==index?true:false,index,widget.items[index].gender));
      list.add(Divider());
    }
    return list;
  }
  Widget checkItem(String title,bool val,int index,String gender){
    return
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
        onTap: (){
          widget.checkedIndex = index;
          widget.parentAction(index);
          setState(() {
          });
        },
        child: Row(
          children: [
            gender != null ?Expanded(
                flex: 1,
                child:
                Container(
                  padding: EdgeInsets.all(5.0),
                  decoration:BoxDecoration(
                    shape: BoxShape.circle,
                    color:Get.theme.accentColor.withAlpha(50),
                    // border: Border.all(color: Colors.blueAccent)
                  ),
                  child: Image(image: AssetImage(
                  gender.toLowerCase() == "male"? 'asset/images/male.png':
                  gender.toLowerCase() == "female"? 'asset/images/female.png':
                  gender.toLowerCase() == "other"? 'asset/images/other.png':''
                  ),height: 35,width: 35,),
                ),
              ):Container(),
            Expanded(flex:5,child: Text(title)),
            Expanded(
              flex: 1,
              child: CircularCheckBox(
                  activeColor: Colors.green,
                  value: val,
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  onChanged: (bool selected) {
                    if(selected == true) {
                      widget.checkedIndex = index;
                      widget.parentAction(index);
                    }
                    setState(() {
                    });
                  }
                // setState(() {
                // });
              ),
            ),
            // Checkbox(value: value, onChanged:(value){

            //
            // }),
          ],
        ),
    ),
      );
  }
}


