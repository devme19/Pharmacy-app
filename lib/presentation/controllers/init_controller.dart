import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/status_entity.dart';
import 'package:navid_app/domain/usecases/init/get_status_use_case.dart';
import 'package:navid_app/utils/helper.dart';

class InitController extends GetxController{
  Rx<StatusEntity> statusEntity = new StatusEntity().obs;
  getStatusList(bool isSplash){
    GetStatusUseCase getStatusUseCase  = Get.find();
    getStatusUseCase.call(Params(boolValue: isSplash)).then((response){
      if(response.isRight){
        statusEntity.value = response.right;
      }
      else if(response.isLeft)
        errorAction(response.left);
    });
  }
}