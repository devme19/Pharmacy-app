import 'package:get/get.dart';
import 'package:navid_app/domain/usecases/order/add_order_use_case.dart';
import 'package:navid_app/domain/usecases/order/get_orders_use_case.dart';
import 'package:navid_app/presentation/controllers/history_controller.dart';

class HistoryBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<GetOrdersUseCase>(() => GetOrdersUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<AddOrderUseCase>(() => AddOrderUseCase(
      repository: Get.find()
    ));
    Get.lazyPut<HistoryController>(() => HistoryController());
  }

}