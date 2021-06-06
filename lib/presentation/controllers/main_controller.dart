import 'dart:io';

import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';

class MainController extends GetxController{
  logOut(){
    LogOutUseCase logOutUseCase = Get.find();
    logOutUseCase.call(NoParams()).then((response){
      Get.offAndToNamed(NavidAppRoutes.loginPage);
    });
  }
}