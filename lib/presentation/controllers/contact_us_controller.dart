import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/usecases/support/contact_us_use_case.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class ContactUsController extends GetxController{

  var sendStatus = StateStatus.INITIAL.obs;
  sendMessage(Map body,ValueChanged<bool> done){
    sendStatus.value = StateStatus.LOADING;
    ContactUsUseCase contactUsUseCase = Get.find();
    contactUsUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        sendStatus.value = StateStatus.SUCCESS;
        MyAlertDialog.show(["Message sent"], true,null);
        done(true);

      }else if(response.isLeft){
        sendStatus.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
}