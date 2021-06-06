import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/setting/get_font_size_use_case.dart';
import 'package:navid_app/domain/usecases/setting/set_font_size_use_case.dart';
import 'package:navid_app/presentation/controllers/setting_controller.dart';

class SettingBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(() => SettingController());

  }

}