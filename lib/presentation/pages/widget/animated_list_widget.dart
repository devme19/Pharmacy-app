import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/presentation/controllers/prescription_controller.dart';
class AnimatedListWidget extends StatefulWidget {

  @override
  _AnimatedListWidgetState createState() => _AnimatedListWidgetState();
}

class _AnimatedListWidgetState extends State<AnimatedListWidget> {
  PrescriptionController controller = Get.put(PrescriptionController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedList(
        controller: controller.scrollController,
        key: controller.listKey,
        initialItemCount: controller.medicineList.length,
        itemBuilder: (BuildContext context, int index, Animation animation) {
          return FadeTransition(
            opacity: animation,
            // child: controller.buildItem(controller.medicineList[index]),
          );
        },
      ),
    );
  }

}
