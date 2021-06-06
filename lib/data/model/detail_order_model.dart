import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/domain/entities/detail_order_entity.dart';

class DetailOrderModel extends DetailOrderEntity{

    DetailOrderModel({
      Data data,
      Buyer buyer,
      Seler seler,
      bool success,

    }):super(
      success: success,
      buyer: buyer,
      seler: seler,
      data: data
    );

    factory DetailOrderModel.fromJson(Map<String, dynamic> json) {
        return DetailOrderModel(
            data: json['data'] != null ? Data.fromJson(json['data']) : null,
            buyer: json['buyer'] != null ? Buyer.fromJson(json['buyer']) : null, 
            seler: json['seler'] != null ? Seler.fromJson(json['seler']) : null, 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        if (this.buyer != null) {
            data['buyer'] = this.buyer.toJson();
        }
        if (this.seler != null) {
            data['seler'] = this.seler.toJson();
        }
        return data;
    }
}

class Buyer {
    Object actived;
    String address;
    Object api_token;
    String birthday;
    String city;
    String country;
    String created_at;
    String email;
    String family;
    String gender;
    int id;
    String name;
    String nhs_number;
    String phone;
    String postalcode;
    String updated_at;

    Buyer({this.actived, this.address, this.api_token, this.birthday, this.city, this.country, this.created_at, this.email, this.family, this.gender, this.id, this.name, this.nhs_number, this.phone, this.postalcode, this.updated_at});

    factory Buyer.fromJson(Map<String, dynamic> json) {
        return Buyer(
            actived: json['actived'] ,
            address: json['address'], 
            api_token: json['api_token'],
            birthday: json['birthday'], 
            city: json['city'], 
            country: json['country'], 
            created_at: json['created_at'], 
            email: json['email'], 
            family: json['family'], 
            gender: json['gender'], 
            id: json['id'], 
            name: json['name'], 
            nhs_number: json['nhs_number'], 
            phone: json['phone'], 
            postalcode: json['postalcode'], 
            updated_at: json['updated_at'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['birthday'] = this.birthday;
        data['city'] = this.city;
        data['country'] = this.country;
        data['created_at'] = this.created_at;
        data['email'] = this.email;
        data['family'] = this.family;
        data['gender'] = this.gender;
        data['id'] = this.id;
        data['name'] = this.name;
        data['nhs_number'] = this.nhs_number;
        data['phone'] = this.phone;
        data['postalcode'] = this.postalcode;
        data['updated_at'] = this.updated_at;
        data['actived'] = this.actived;
        data['api_token'] = this.api_token;
        return data;
    }
}

class Seler {
    String address;
    String phone;

    Seler({this.address, this.phone});

    factory Seler.fromJson(Map<String, dynamic> json) {
        return Seler(
            address: json['address'], 
            phone: json['phone'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['address'] = this.address;
        data['phone'] = this.phone;
        return data;
    }
}