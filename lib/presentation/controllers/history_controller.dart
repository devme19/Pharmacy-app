import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/config/config.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/domain/entities/order_entity.dart';
import 'package:navid_app/domain/usecases/order/add_order_use_case.dart';
import 'package:navid_app/domain/usecases/order/get_orders_use_case.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';
class HistoryController extends GetxController{
  var getOrdersStatus = StateStatus.INITIAL.obs;
  var reOrdersStatus = StateStatus.INITIAL.obs;
  List<Data> orders = new List();
  RxInt isDeleted = 0.obs;
  int pageIndex;
  RxString userInfo = "".obs;
  deleteOrder(String id){
    orders.remove(orders.singleWhere((i) => i.id.toString() == id));
  }
  getOrders(String parameters){
    getOrdersStatus.value = StateStatus.LOADING;
    GetOrdersUseCase getOrdersUseCase = Get.find();
    getOrdersUseCase.call(Params(value: parameters)).then((response) {
      if(response.isRight){
        getOrdersStatus.value = StateStatus.SUCCESS;
        orders.addAll(response.right.data);
        pageIndex = response.right.page;
      }else if(response.isLeft){
        getOrdersStatus.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
  onTap(int index,bool isExpanded){
    orders[index].isExpanded = !isExpanded;
    update();
  }
}