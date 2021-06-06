import 'package:navid_app/domain/entities/login_entity.dart';

class IdentityModel extends IdentityEntity{

    IdentityModel({
      String message,
      bool success,
      String token,
    }):super(
      message: message,
      success: success,
      token: token
    );

    factory IdentityModel.fromJson(Map<String, dynamic> json) {
        return IdentityModel(
            message: json['message'], 
            success: json['success'], 
            token: json['token'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['success'] = this.success;
        data['token'] = this.token;
        return data;
    }
}