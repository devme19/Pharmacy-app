import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:navid_app/presentation/controllers/home_controller.dart';
import 'package:navid_app/presentation/controllers/main_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';

class ServerException implements Exception {
  int errorCode;
  List<String> errorMessage;
  String url;

  ServerException(int errorCode,String url){
    errorMessage = new List();
    this.errorCode = errorCode;
    if(errorCode == 401 && !url.contains("login")) {

      Get.offAllNamed(NavidAppRoutes.loginPage);
    } else
    if(errorCode == 401 && url.contains("login"))
      errorMessage.add("Email or password is incorrect".tr);
    else
    if(errorCode == 402 && url.contains("user/reset"))
      errorMessage.add("User not exist".tr);
    else
    if(errorCode == 422&& url.contains("register"))
      errorMessage.add("Email already received has been registered".tr);
    else
    if(errorCode == 422&& url.contains("changePassword"))
      errorMessage.add("Old Password does not match".tr);
    else
    if(errorCode == 422&& url.contains("drug"))
      errorMessage.add("Not Found".tr);
    else
      if(errorCode==0 || errorCode == 1)
        errorMessage.add("unable to connect".tr);
      else
        errorMessage.add("Unhandled error".tr);
}
}

class CacheException implements Exception {}
