import 'package:navid_app/domain/entities/non_payment_entity.dart';

class NonPaymentModel extends NonPaymentEntity{


    NonPaymentModel({
      List<Data> data,
      bool success,
    }):super(success: success,data: data);

    factory NonPaymentModel.fromJson(Map<String, dynamic> json) {
        return NonPaymentModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    int id;
    String title;

    Data({this.id, this.title});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            id: json['id'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}