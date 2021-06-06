import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/get_accounts_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_user_info_use_case.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';
import 'package:navid_app/domain/usecases/user/update_dependent_use_case.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<LogOutUseCase>(() => LogOutUseCase(
        repository: Get.find()
    ));

  }

}