import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/order/get_order_use_case.dart';
import 'package:navid_app/presentation/controllers/detail_order_controller.dart';

class DetailOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DetailOrderController>(() => DetailOrderController());
    Get.lazyPut<GetDetailOrderUseCase>(() => GetDetailOrderUseCase(
      repository: Get.find()
    ));
  }

}