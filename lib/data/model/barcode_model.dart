import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:navid_app/domain/entities/barcode_entity.dart';

class BarCodeModel extends BarCodeEntity{


    BarCodeModel({
      Data data,
      bool success,
}):super(success: success,data: data);

    factory BarCodeModel.fromJson(Map<String, dynamic> json) {
        return BarCodeModel(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class Data {
    String code;
    String created_at;
    int id;
    String title;
    String updated_at;

    Data({this.code, this.created_at, this.id, this.title, this.updated_at});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            code: json['code'], 
            created_at: json['created_at'], 
            id: json['id'], 
            title: json['title'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['title'] = this.title;
        data['updated_at'] = this.updated_at;
        return data;
    }
}