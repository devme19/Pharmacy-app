import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/user/reset_password_use_case.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';
import 'package:get/get.dart';
class ResetPasswordController extends GetxController{
  var resetPasswordState = StateStatus.INITIAL.obs;
  resetPassword(Map body){
    resetPasswordState.value = StateStatus.LOADING;
    ResetPasswordUseCase resetPasswordUseCase = Get.find();
    resetPasswordUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        resetPasswordState.value = StateStatus.SUCCESS;
        MyAlertDialog.show(["Password reset link sent to email"], true,null);
      }else if(response.isLeft){
        resetPasswordState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
}