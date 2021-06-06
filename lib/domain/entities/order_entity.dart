import 'package:navid_app/data/model/order_model.dart';

class OrderEntity{
  List<Data> data;
  bool success;
  int page;
  int pagesize;
  int total;
  OrderEntity({
    this.data,
    this.success,
    this.page,
    this.pagesize,
    this.total
  });
}