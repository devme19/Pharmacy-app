import 'package:navid_app/domain/entities/user_entity.dart';

class UserModel extends UserEntity{

    UserModel({
        int actived,
        String address,
        String api_token,
        String birthday,
        String city,
        String country,
        String created_at,
        String email,
        String family,
        String gender,
        int id,
        String name,
        String nhs_number,
        String phone,
        String postalcode,
        String updated_at,
        Payment payment,
        String address_2,
        String gp_address,
        int payment_code,
        int payment_none_id,
    }):super(
        actived: actived,
        address: address,
        api_token: api_token,
        birthday: birthday,
        city: city,
        country: country,
        created_at: created_at,
        email: email,
        family: family,
        gender: gender,
        id: id,
        name: name,
        nhs_number: nhs_number,
        phone: phone,
        postalcode: postalcode,
        updated_at: updated_at,
        payment: payment,
        address_2: address_2,
        gp_address: gp_address,
        payment_code: payment_code,
        payment_none_id: payment_none_id
    );

    factory UserModel.fromJson(Map<String, dynamic> json) {
        if(json['user'] != null)
            json = json['user'];
        else
        if(json['data'] != null)
            json = json['data'];
        return UserModel(
            actived: json['actived'],
            address: json['address'],
            address_2: json['address_2'],
            gp_address: json['gp_address'],
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
            payment_code: json['payment_code'],
            payment_none_id: json['payment_none_id'],
            updated_at: json['updated_at'],
            payment:json['payment'] != null ? Payment.fromJson(json['payment']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['actived'] = this.actived;
        data['address'] = this.address;
        data['address_2'] = this.address_2;
        data['api_token'] = this.api_token;
        data['birthday'] = this.birthday;
        data['city'] = this.city;
        data['country'] = this.country;
        data['gp_address'] = this.gp_address;
        data['created_at'] = this.created_at;
        data['email'] = this.email;
        data['family'] = this.family;
        data['gender'] = this.gender;
        data['id'] = this.id;
        data['name'] = this.name;
        data['payment_none_id'] = this.payment_none_id;
        data['payment_code'] = this.payment_code;
        data['nhs_number'] = this.nhs_number;
        data['phone'] = this.phone;
        data['postalcode'] = this.postalcode;
        data['updated_at'] = this.updated_at;
        return data;
    }
}

class Payment {
    int id;
    String title;

    Payment({this.id, this.title});

    factory Payment.fromJson(Map<String, dynamic> json) {
        return Payment(
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