import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/usecases/user/get_user_info_use_case.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/change_password_page.dart';
import 'package:navid_app/presentation/pages/dashboard_page.dart';
import 'package:navid_app/presentation/pages/eps_nomination_page.dart';
import 'package:navid_app/presentation/pages/my_dependents_page.dart';
import 'package:navid_app/presentation/pages/prescription_page.dart';
import 'package:navid_app/presentation/pages/settings_page.dart';
import 'package:navid_app/presentation/pages/widget/content_widget.dart';
import 'package:navid_app/utils/filter.dart';
import 'package:navid_app/utils/helper.dart';

class HomeController extends GetxController{
  RxInt selectedIndex = 0.obs;
  Rx<UserEntity> userInfo = UserEntity().obs;
  Rx<ContentWidget> body = ContentWidget(body: Container(),).obs;
  RxString title = "Dashboard".obs;
  RxString accountName ="".obs;
  @override
  void onInit() {
    super.onInit();
  }

  onMenuTapped(int index){
    selectedIndex.value = index;
    switch(index){
      case(0):
        body.value = ContentWidget(body: DashBoardPage());
        break;
      case(1):
        // body.value = ContentWidget(body: EpsNominationPage());
        Get.toNamed(NavidAppRoutes.epsNominationPage).then((value) {
          // getUserInfo();
          ContentWidget(body: DashBoardPage());
        });
        // title.value = "EPS Nomination";
        break;
      case(2):
        Get.toNamed(NavidAppRoutes.prescriptionPage,arguments: [null,false,null,null]).then((value) =>  ContentWidget(body: DashBoardPage()));
        break;
      case(3):
        Get.toNamed(NavidAppRoutes.historyPage,arguments: [accountName.value,null]).then((value) =>  ContentWidget(body: DashBoardPage()));
        break;
      case(4):
        Get.toNamed(NavidAppRoutes.myDependentsPage).then((value) =>  ContentWidget(body: DashBoardPage()));
        break;
      case(5):
        Get.toNamed(NavidAppRoutes.settingPage);
        break;
      case(6):
        Get.toNamed(NavidAppRoutes.changePassword);
        break;
      case(7):
        Get.toNamed(NavidAppRoutes.contactUsPage);
        break;
    }
  }
  getUserInfo(){
    GetUserInfoUseCase getUserInfoUseCase = Get.find();
    getUserInfoUseCase.call(NoParams()).then((response) {
      if(response.isRight) {
        userInfo.value = response.right;
        accountName.value = userInfo.value.name+" "+userInfo.value.family;
      } else
        if(response.isLeft)
          errorAction(response.left);
    });
  }


}