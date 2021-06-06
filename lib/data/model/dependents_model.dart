import 'package:navid_app/data/model/user_model.dart';
import 'package:navid_app/domain/entities/dependents_entity.dart';

class DependentsModel extends DependentsEntity{

    DependentsModel({
        List<UserModel> data,
        bool success,
    }):super(
        success: success,
        data: data
    );

    factory DependentsModel.fromJson(Map<String, dynamic> json) {
        return DependentsModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => UserModel.fromJson(i)).toList() : null,
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