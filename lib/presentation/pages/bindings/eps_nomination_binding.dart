import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/user/add_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_non_payment_reason_use_case.dart';
import 'package:navid_app/domain/usecases/user/update_dependent_use_case.dart';
import 'package:navid_app/domain/usecases/user/update_user_use_case.dart';
import 'package:navid_app/presentation/controllers/eps_nomination_controller.dart';
import 'package:navid_app/presentation/controllers/user_controller.dart';

class EpsNominationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<EpsNominationController>(() => EpsNominationController());
    Get.lazyPut<GetDependentUseCase>(() => GetDependentUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<UpdateDependentUseCase>(() => UpdateDependentUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<AddDependentUseCase>(() => AddDependentUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<UpdateUserUseCase>(() => UpdateUserUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetNonPaymentReasonUseCase>(() => GetNonPaymentReasonUseCase(
      repository: Get.find()
    ));
  }

}