import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/detail_order_entity.dart';
import 'package:navid_app/domain/usecases/order/get_order_use_case.dart';
import 'package:navid_app/utils/state_status.dart';

class DetailOrderController extends GetxController{
  var getDetailOrderState = StateStatus.INITIAL.obs;
  Rx<DetailOrderEntity> detailOrder = DetailOrderEntity().obs;
  getDetailOrder(String id){
    getDetailOrderState.value = StateStatus.LOADING;
    GetDetailOrderUseCase getDetailOrderUseCase = Get.find();
    getDetailOrderUseCase.call(Params(id: id)).then((response){
      if(response.isRight){
        getDetailOrderState.value = StateStatus.SUCCESS;
        detailOrder.value = response.right;
      }
      else
        if(response.isLeft){
          getDetailOrderState.value = StateStatus.ERROR;
        }
    });
  }
}