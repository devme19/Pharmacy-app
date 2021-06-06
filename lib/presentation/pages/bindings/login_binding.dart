import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/login_use_case.dart';
import 'package:navid_app/presentation/controllers/identity_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(() => LoginUseCase(
      repository: Get.find()
    ));
  }

}