import 'package:navid_app/data/model/add_order_response_model.dart';
import 'package:navid_app/data/model/barcode_model.dart';
import 'package:navid_app/data/model/dashboard_model.dart';
import 'package:navid_app/data/model/dependents_model.dart';
import 'package:navid_app/data/model/detail_order_model.dart';
import 'package:navid_app/data/model/drug_model.dart';
import 'package:navid_app/data/model/identity_model.dart';
import 'package:navid_app/data/model/non_payment_model.dart';
import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/data/model/status_model.dart';
import 'package:navid_app/data/model/user_model.dart';
import 'package:navid_app/domain/entities/dashboard_entity.dart';

class Generics {
  static T fromJson<T,K>(dynamic json) {
    print(T);
    print(K);
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    }
    else
    if (T == UserModel) {
      return UserModel.fromJson(json) as T;
    }
    else
    if (T == IdentityModel) {
      return IdentityModel.fromJson(json) as T;
    }
    else
    if (T == DependentsModel) {
      return DependentsModel.fromJson(json) as T;
    }
    else
    if (T == OrderModel) {
      return OrderModel.fromJson(json) as T;
    }
    else
    if (T == DetailOrderModel) {
      return DetailOrderModel.fromJson(json) as T;
    }
    else
    if (T == DashboardModel) {
      return DashboardModel.fromJson(json) as T;
    }
    else
    if (T == StatusModel) {
      return StatusModel.fromJson(json) as T;
    }
    else
    if (T == DrugModel) {
      return DrugModel.fromJson(json) as T;
    }
    else
    if (T == AddOrderResponseModel) {
      return AddOrderResponseModel.fromJson(json) as T;
    }
    else
    if (T == NonPaymentModel) {
      return NonPaymentModel.fromJson(json) as T;
    }
    else
    if (T == BarCodeModel) {
      return BarCodeModel.fromJson(json) as T;
    }
    else
      {
        throw Exception("Unknown class");
      }

  }
  static List<K> _fromJsonList<K>(List jsonList) {
    if (jsonList == null) {
      return null;
    }

    List<K> output = List();

    for (Map<String, dynamic> json in jsonList) {
      output.add(fromJson(json));
    }
    return output;
  }
}