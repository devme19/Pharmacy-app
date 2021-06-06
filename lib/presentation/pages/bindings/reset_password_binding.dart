import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/reset_password_use_case.dart';
import 'package:navid_app/presentation/controllers/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
    Get.lazyPut<ResetPasswordUseCase>(() => ResetPasswordUseCase(
      repository: Get.find(),
    ));
  }

}