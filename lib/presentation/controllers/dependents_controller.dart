import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/dependents_entity.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/usecases/user/get_dependents_use_case.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class DependentsController extends GetxController{
  List<UserEntity> myDependents = new List();
  var getDependentsState = StateStatus.INITIAL.obs;
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