import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/change_password_use_case.dart';
import 'package:navid_app/presentation/controllers/change_password_controller.dart';

class ChangePasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordUseCase>(() => ChangePasswordUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }

}