import 'package:navid_app/domain/entities/dashboard_entity.dart';

class DashboardModel extends DashboardEntity{
    DashboardModel({
      int count_delivered,
      int count_order,
      int count_pending,
      List<Family> family,
      bool status,
    }):super(
      family: family,
      status: status,
      count_delivered: count_delivered,
      count_order: count_order,
      count_pending: count_pending,
    );

    factory DashboardModel.fromJson(Map<String, dynamic> json) {
        return DashboardModel(
            count_delivered: json['count_delivered'], 
            count_order: json['count_order'], 
            count_pending: json['count_pending'],
            family: json['family'] != null ? (json['family'] as List).map((i) => Family.fromJson(i)).toList() : null,
            status: json['status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count_delivered'] = this.count_delivered;
        data['count_order'] = this.count_order;
        data['count_pending'] = this.count_pending;
        data['status'] = this.status;
        if (this.family != null) {
            data['family'] = this.family.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Family {
    int count_order_family;
    String family;
    String name;
    String gender;
    String phone;
    int id;
    Family({this.count_order_family, this.family, this.name,this.gender,this.id,this.phone});

    factory Family.fromJson(Map<String, dynamic> json) {
        return Family(
            count_order_family: json['count_order_family'], 
            family: json['family'], 
            name: json['name'], 
            phone: json['phone'],
            id: json['id'],
            gender: json['gender'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['count_order_family'] = this.count_order_family;
        data['family'] = this.family;
        data['id'] = this.id;
        data['gender'] = this.gender;
        data['phone'] = this.phone;
        data['name'] = this.name;
        return data;
    }
}