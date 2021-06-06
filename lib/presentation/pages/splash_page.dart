import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';
import 'package:navid_app/presentation/controllers/splash_controller.dart';
import 'package:navid_app/presentation/pages/widget/connection_error.dart';
import 'package:navid_app/utils/state_status.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        body: Center(
          child:
          Obx(()=>splashController.loginState.value == StateStatus.LOADING?
          Container(
              child: SpinKitFoldingCube(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              )
          ):splashController.loginState.value == StateStatus.ERROR?ConnectionError(parentAction: reConnect,):Container(),)
        ),
      );
  }

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
     splashController.isLogin();
    });
  }
  reConnect(bool ){
    splashController.isLogin();
  }
}

