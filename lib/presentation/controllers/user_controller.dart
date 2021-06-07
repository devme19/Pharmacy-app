import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/data/model/user_model.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/usecases/user/add_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_accounts_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_dependents_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_non_payment_reason_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_user_info_use_case.dart';
import 'package:navid_app/domain/usecases/user/is_login_use_case.dart';
import 'package:navid_app/domain/usecases/user/login_use_case.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';
import 'package:navid_app/domain/usecases/user/update_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/update_user_use_case.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class UserController extends GetxController{
  Rx<UserEntity> userInfo = UserEntity().obs;

  RxList myDependents = [].obs;
  var getDependentsState = StateStatus.INITIAL.obs;
  var getUserInfoState = StateStatus.INITIAL.obs;
  var addDependentState = StateStatus.INITIAL.obs;
  var updateUserState = StateStatus.INITIAL.obs;
  var getDependentState = StateStatus.INITIAL.obs;
  var updateDependentState = StateStatus.INITIAL.obs;
  var getReasonState = StateStatus.INITIAL.obs;
  HomeController homeController;
  RxList reasons = [].obs;

  RxList accounts = [].obs;
  RxString accountName = "".obs;

  getReasons(){
    getReasonState.value = StateStatus.LOADING;
    GetNonPaymentReasonUseCase getNonPaymentReasonUseCase = Get.find();
    getNonPaymentReasonUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        getReasonState.value = StateStatus.SUCCESS;
        reasons.addAll(response.right.data);
      }
      else if(response.isLeft){
        getReasonState.value = StateStatus.ERROR;
      }
    });
  }
  getUserInfo(ValueChanged<UserEntity> parentAction){
    getUserInfoState.value = StateStatus.LOADING;
    GetUserInfoUseCase getUserInfoUseCase =Get.find();
    getUserInfoUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        getUserInfoState.value = StateStatus.SUCCESS;
        userInfo.value = response.right;
        if(parentAction != null)
          parentAction(userInfo.value);
      }else if(response.isLeft){
        getUserInfoState.value = StateStatus.ERROR;
      }
    });
  }
  getMyDependents(){
    getDependentsState.value = StateStatus.LOADING;
    GetDependentsUseCase getDependentsUseCase = Get.find();
    getDependentsUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        getDependentsState.value = StateStatus.SUCCESS;
          // myDependents.addAll(response.right.data);
      }
      else if(response.isLeft){
        getDependentsState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  getDependent(String id,ValueChanged<UserEntity> parentAction){
    getDependentState.value = StateStatus.LOADING;
    GetDependentUseCase getDependentUseCase = Get.find();
    getDependentUseCase.call(Params(id: id)).then((response) {
      if(response.isRight){
        getDependentState.value = StateStatus.SUCCESS;
        parentAction(response.right);
      }
      else if(response.isLeft){
        getDependentsState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  updateUser(Map body,bool isRegistered){
    updateUserState.value = StateStatus.LOADING;
    UpdateUserUseCase updateUserUseCase =Get.find();
    updateUserUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        updateUserState.value = StateStatus.SUCCESS;
        if(isRegistered) {
          Get.offAndToNamed(NavidAppRoutes.homePage);
          // homeController.getUserInfo();
        } else {
          homeController = Get.put(HomeController());
          homeController.getUserInfo();
          Get.back();
        }
      }else if(response.isLeft){
        updateUserState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
  updateDependent(String id,Map body){
    updateDependentState.value = StateStatus.LOADING;
    UpdateDependentUseCase updateDependentUseCase =Get.find();
    updateDependentUseCase.call(Params(body: body,id: id)).then((response) {
      if(response.isRight){
        updateDependentState.value = StateStatus.SUCCESS;
        Get.back();
      }else if(response.isLeft){
        updateDependentState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }
  addDependent(Map body){
    addDependentState.value = StateStatus.LOADING;
    AddDependentUseCase  addDependentUseCase = Get.find();
    addDependentUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        addDependentState.value =StateStatus.SUCCESS;
        Get.back();
      }
      else if(response.isLeft){
        addDependentState.value = StateStatus.ERROR;
        // errorAction(response.left);
      }
    });
  }

}