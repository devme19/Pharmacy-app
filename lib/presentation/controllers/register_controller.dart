import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/user/register_use_case.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class RegisterController extends GetxController{

  RxBool obscureTextPassword = true.obs;
  RxBool obscureTextRePassword = true.obs;
  RxBool readAgreement = false.obs;
  var registerStatus = StateStatus.INITIAL.obs;
  RxInt agreementState = 0.obs;

  onReadAgreementCheck(){
    readAgreement.value = !readAgreement.value;
    if(readAgreement.value)
      agreementState.value = 1;
    else
      agreementState.value = 0;
  }
  register(Map body){
    registerStatus.value = StateStatus.LOADING;
    RegisterUseCase registerUseCase = Get.find();
    registerUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        registerStatus.value = StateStatus.SUCCESS;
        Get.offAllNamed(NavidAppRoutes.epsNominationPage,arguments: true);
      }else if(response.isLeft){
        registerStatus.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  obscurePassword(){
    obscureTextPassword.value = !obscureTextPassword.value;
  }
  obscureRePassword(){
    obscureTextRePassword.value = !obscureTextRePassword.value;
  }
}