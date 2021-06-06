import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/get_user_info_use_case.dart';
import 'package:navid_app/domain/usecases/user/is_login_use_case.dart';
import 'package:navid_app/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
    Get.lazyPut<IsLoginUseCase>(() => IsLoginUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetUserInfoUseCase>(() => GetUserInfoUseCase(
      repository: Get.find()
    ));
  }

}