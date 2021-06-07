import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/delete_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_dependents_use_case.dart';
import 'package:navid_app/presentation/controllers/dependents_controller.dart';

class MyDependentsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DependentsController>(() => DependentsController());
    Get.lazyPut<GetDependentsUseCase>(() => GetDependentsUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<DeleteDependentUseCase>(() => DeleteDependentUseCase(
      repository: Get.find()
    ));
  }

}