import 'package:navid_app/domain/entities/add_order_response_entity.dart';

class AddOrderResponseModel extends AddOrderResponseEntity{

    AddOrderResponseModel({
      int id,
      String message,
      bool success,
    }):super(
        id: id,
      success: success,
      message: message
    );

    factory AddOrderResponseModel.fromJson(Map<String, dynamic> json) {
        return AddOrderResponseModel(
            id: json['id'], 
            message: json['message'], 
            success: json['success'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['message'] = this.message;
        data['success'] = this.success;
        return data;
    }
}