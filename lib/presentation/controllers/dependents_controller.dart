import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/dependents_entity.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/usecases/user/delete_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_dependents_use_case.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class DependentsController extends GetxController{
  List<UserEntity> myDependents = new List();
  RxInt listLength = (-1).obs;
  String deletedUserId = '';
  var getDependentsState = StateStatus.INITIAL.obs;
  var deleteDependentsState = StateStatus.INITIAL.obs;
  deleteDependent(String id){
    deletedUserId = id;
    deleteDependentsState.value = StateStatus.LOADING;
    DeleteDependentUseCase deleteDependentUseCase = Get.find();
    deleteDependentUseCase.call(Params(id: id)).then((response) {
      if(response.isRight){
        deleteDependentsState.value = StateStatus.SUCCESS;
        UserEntity deletedUser = myDependents.firstWhere((user) => user.id.toString() == id);
        myDependents.remove(deletedUser);
        listLength.value = myDependents.length;
      }else if(response.isLeft){
        deleteDependentsState.value = StateStatus.ERROR;
      }
    });
  }
  getMyDependents(){
    getDependentsState.value = StateStatus.LOADING;
    GetDependentsUseCase getDependentsUseCase = Get.find();
    getDependentsUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        getDependentsState.value = StateStatus.SUCCESS;
        myDependents.addAll(response.right.data);
        // myDependents.addAll(response.right.data);
      }
      else if(response.isLeft){
        getDependentsState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
}