import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/dashboard_entity.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/usecases/dashboard/dashboard_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_user_info_use_case.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class DashboardController extends GetxController{
  var getDashoardStatus = StateStatus.INITIAL.obs;
  var getUserInfoStatus = StateStatus.INITIAL.obs;
  Rx<DashboardEntity> dashboardEntity = new DashboardEntity().obs;
  Rx<UserEntity> userInfo = new UserEntity().obs;
  @override
  void onInit() {
    super.onInit();
    // getDashboard();
    // getUserInfo();
  }

  getDashboard(){
    getDashoardStatus.value = StateStatus.LOADING;
    DashboardUseCase dashboardUseCase = Get.find();
    dashboardUseCase.call(NoParams()).then((response){
      if(response.isRight){
        getDashoardStatus.value = StateStatus.SUCCESS;
        dashboardEntity.value = response.right;
      }else if (response.isLeft){
        getDashoardStatus.value = StateStatus.ERROR;
      }
    });
  }
  getUserInfo(){
    getUserInfoStatus.value = StateStatus.LOADING;
    GetUserInfoUseCase getUserInfoUseCase = Get.find();
    getUserInfoUseCase.call(NoParams()).then((response) {
      if(response.isRight) {
        getUserInfoStatus.value = StateStatus.SUCCESS;
        userInfo.value = response.right;
      } else
      if(response.isLeft)
        errorAction(response.left);
    });
  }
}