
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/setting/get_font_size_use_case.dart';
import 'package:navid_app/domain/usecases/setting/get_mode_use_case.dart';
import 'package:navid_app/domain/usecases/setting/set_font_size_use_case.dart';
import 'package:navid_app/domain/usecases/setting/set_mode_use_case.dart';

class SettingController extends GetxController{
  RxDouble fontSize = 15.0.obs;
  RxBool darkMode = false.obs;
  double historyItemHeight = 100;
  RxString toggle ="".obs;


  @override
  void onInit() {
    GetStorage box = GetStorage();
    if(box.read('fontSize') != null)
      fontSize.value = box.read('fontSize');
    if(box.read('darkMode') != null)
      darkMode.value = box.read('darkMode');
   setToggleValue();

    initialize();
    super.onInit();
  }

  changeFontSize(double size){
    SetFontSizeUseCase fontSizeUseCase = Get.find();
    fontSizeUseCase.call(Params(value: size.toString())).then((value) {});
    fontSize.value = size;
    initialize();
  }
  getFontSize(){
    GetFontSizeUseCase getFontSizeUseCase = Get.find();
    getFontSizeUseCase.call(NoParams()).then((value) {
      fontSize.value = value.right;

      initialize();
    });
  }
  initialize(){
    historyItemHeight = 100+(15*(fontSize.value-(fontSize.value/3)));
    // historyItemHeight = 210+(1.5*fontSize.value);
  }
  setMode(bool mode){
    SetModeUseCase setModeUseCase = Get.find();
    setModeUseCase.call(Params(boolValue: mode)).then((value) {
      darkMode.value = mode;
      setToggleValue();
    });
  }
  getMode(){
    GetModeUseCase getModeUseCase = Get.find();
    getModeUseCase.call(NoParams()).then((mode) {
      darkMode.value = mode.right;
      setToggleValue();
    });
  }
  setToggleValue(){
    if(darkMode.value)
      toggle.value = "OFF";
    else
      toggle.value = "ON";
  }
}