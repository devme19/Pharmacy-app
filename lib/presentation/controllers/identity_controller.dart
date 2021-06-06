import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/user/login_use_case.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

import 'init_controller.dart';

class IdentityController extends GetxController{
  RxBool obscureText = true.obs;
  var loginState = StateStatus.INITIAL.obs;
  obscurePassword(){
    obscureText.value = !obscureText.value;
  }
  login(Map body){
    loginState.value = StateStatus.LOADING;
    LoginUseCase loginUseCase = Get.find();
    loginUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        loginState.value = StateStatus.SUCCESS;
        Get.offAndToNamed(NavidAppRoutes.homePage);
        InitController initController = Get.put(InitController());
        initController.getStatusList(true);
      }else if(response.isLeft){
        loginState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
}