import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/order/add_order_use_case.dart';
import 'package:navid_app/domain/usecases/order/delete_order_use_case.dart';
import 'package:navid_app/domain/usecases/order/get_drug_by_barcode_use_case.dart';
import 'package:navid_app/domain/usecases/order/get_drugs_usecase.dart';
import 'package:navid_app/domain/usecases/order/update_order_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_accounts_use_case.dart';
import 'package:navid_app/domain/usecases/user/logout_use_case.dart';

import 'package:navid_app/presentation/controllers/prescription_controller.dart';

class PrescriptionBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AddOrderUseCase>(() => AddOrderUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetDrugByBarCodeUseCase>(() => GetDrugByBarCodeUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<GetAccountsUseCase>(() => GetAccountsUseCase(
        repository: Get.find()
    ));
    Get.lazyPut<UpdateOrderUseCase>(() => UpdateOrderUseCase(
      repository: Get.find()
    ));
  Get.lazyPut<DeleteOrderUseCase>(() => DeleteOrderUseCase(
    repository: Get.find()
  ));
    Get.lazyPut<PrescriptionController>(() => PrescriptionController());
  Get.lazyPut<GetDrugsUseCase>(() => GetDrugsUseCase(
    repository: Get.find()
  ));
  }

}