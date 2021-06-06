import 'package:navid_app/data/model/detail_order_model.dart';
import 'package:navid_app/data/model/order_model.dart';

class DetailOrderEntity{
  Data data;
  Buyer buyer;
  Seler seler;
  bool success;

  DetailOrderEntity({
    this.data,
    this.buyer,
    this.seler,
    this.success
});
}