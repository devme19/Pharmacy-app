import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/user/change_password_use_case.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class ChangePasswordController extends GetxController{
  var changePasswordState = StateStatus.INITIAL.obs;

  changePassword(Map body,ValueChanged<bool> done){
    changePasswordState.value  = StateStatus.LOADING;
    ChangePasswordUseCase changePasswordUseCase = Get.find();
    changePasswordUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        changePasswordState.value  = StateStatus.SUCCESS;
        MyAlertDialog.show(["Password successfully changed"], true,null);
        done(true);
      }else if(response.isLeft){
        changePasswordState.value  = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
}