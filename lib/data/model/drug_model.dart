import 'package:get/get.dart';
import 'package:navid_app/domain/entities/drug_entity.dart';

class DrugModel extends DrugEntity{

    DrugModel({
      List<Drug> drugs,
      int page,
      int status,
      int total,}):super(
      drugs: drugs,
      page: page,
      status: status,
      total: total,
    );

    factory DrugModel.fromJson(Map<String, dynamic> json) {
        return DrugModel(
          drugs: json['items'] != null ? (json['items'] as List).map((i) => Drug.fromJson(i)).toList() : null,
            page: json['page'], 
            status: json['status'], 
            total: json['total'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['page'] = this.page;
        data['status'] = this.status;
        data['total'] = this.total;
        if (this.drugs != null) {
            data['items'] = this.drugs.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Drug {
    String title;
    int quantity;
    bool selected = false;

    Drug({this.title,this.quantity});

    factory Drug.fromJson(Map<String, dynamic> json) {
        return Drug(
            title: json['title'], 
            quantity: json['quantity'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['title'] = this.title;
        data['quantity'] = this.quantity;
        return data;
    }
}