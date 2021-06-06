import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/support/contact_us_use_case.dart';
import 'package:navid_app/presentation/controllers/contact_us_controller.dart';

class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ContactUsUseCase>(() => ContactUsUseCase(
      repository: Get.find(),
    ));
    Get.lazyPut<ContactUsController>(() => ContactUsController());
  }

}