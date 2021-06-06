import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/register_use_case.dart';
import 'package:navid_app/presentation/controllers/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<RegisterUseCase>(() => RegisterUseCase(
      repository: Get.find()
    ));
  }

}