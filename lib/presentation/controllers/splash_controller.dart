import 'package:get/get.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/user/is_login_use_case.dart';
import 'package:navid_app/presentation/controllers/init_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class SplashController extends GetxController{
  var loginState = StateStatus.INITIAL.obs;
  isLogin(){
    loginState.value = StateStatus.LOADING;
    IsLoginUseCase isLoginUseCase = Get.find();
    isLoginUseCase.call(NoParams()).then((response) {
      if(response.isRight){
        loginState.value = StateStatus.SUCCESS;
        if (response.right.id != null) {
          Get.offAndToNamed(NavidAppRoutes.homePage);
          InitController initController = Get.put(InitController());
          initController.getStatusList(true);
        } else
          Get.offAndToNamed(NavidAppRoutes.loginPage);
      }
      else
      if(response.isLeft){
        if(response.left == null)
          Get.offAndToNamed(NavidAppRoutes.loginPage);
        else {
          ServerFailure failure = response.left;
          if(failure.errorCode != 401)
          loginState.value = StateStatus.ERROR;
        }
      }
    });
  }
}