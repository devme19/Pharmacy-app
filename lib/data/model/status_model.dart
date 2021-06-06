import 'package:navid_app/domain/entities/status_entity.dart';

class StatusModel extends StatusEntity{

    StatusModel({
      List<Data> data,
      bool success,
    }):super(data: data,success: success);

    factory StatusModel.fromJson(Map<String, dynamic> json) {
        return StatusModel(
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
    String color;
    int id;
    String title;

    Data({this.color, this.id, this.title});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            color: json['color'],
            id: json['id'],
            title: json['title'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['color'] = this.color;
        data['id'] = this.id;
        data['title'] = this.title;
        return data;
    }
}