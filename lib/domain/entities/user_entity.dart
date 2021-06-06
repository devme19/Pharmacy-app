import 'package:navid_app/data/model/user_model.dart';

class UserEntity{
  int actived;
  String address;
  String address_2;
  String api_token;
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
  Payment payment;
  String gp_address;
  int payment_code;
  int payment_none_id;
  UserEntity({
    this.actived,
    this.address,
    this.api_token,
    this.birthday,
    this.city,
    this.country,
    this.created_at,
    this.email,
    this.family,
    this.gender,
    this.id,
    this.name,
    this.nhs_number,
    this.phone,
    this.postalcode,
    this.updated_at,
    this.payment,
    this.address_2,
    this.gp_address,
    this.payment_code,
    this.payment_none_id
  });
}