import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/dashboard/dashboard_use_case.dart';
import 'package:navid_app/presentation/controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardUseCase>(() =>DashboardUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<DashboardController>(() => DashboardController());
  }

}