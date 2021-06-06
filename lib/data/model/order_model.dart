import 'package:get/get.dart';
import 'package:navid_app/data/model/user_model.dart';
import 'package:navid_app/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity{
    OrderModel({
      List<Data> data,
      bool success,
      int page,
      int pagesize,
      int total,
    }):super(
      data: data,
      success: success,
      page: page,
      pagesize: pagesize,
      total: total
    );

    factory OrderModel.fromJson(Map<String, dynamic> json) {
        return OrderModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => Data.fromJson(i)).toList() : null,
            success: json['success'], 
            page: json['page'],
            pagesize: json['pagesize'],
            total: json['total'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['success'] = this.success;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        data['page'] = this.page;
        data['pagesize'] = this.pagesize;
        data['total'] = this.total;
        return data;
    }
}
class Data {
    String created_at;
    String description;
    int familyid;
    int id;
    List<OrderList> orderlist;
    int orderid;
    Status status;
    int status_id;
    String updated_at;
    String user_type;
    int userid;
    UserModel family;
    bool isExpanded=false;
    int reorder = -1;
    RxBool deleted = false.obs;

    Data({this.created_at, this.description, this.familyid, this.id, this.orderlist, this.orderid, this.status, this.status_id, this.updated_at, this.user_type, this.userid,this.family});

    factory Data.fromJson(Map<String, dynamic> json) {
        return Data(
            created_at: json['created_at'], 
            description: json['description'] ,
            familyid: json['familyid'] ,
            id: json['id'],
            orderlist: json['orderlist'] != null ? (json['orderlist'] as List).map((i) => OrderList.fromJson(i)).toList() : null,
            // orderlist: json['orderlist'] != null ? (json['orderlist'] as List).map((i) => Object.fromJson(i)).toList() : null,
            orderid: json['orderid'] ,
            status: json['status']!=null?Status.fromJson(json['status']):null ,
            status_id: json['status_id'] ,
            updated_at: json['updated_at'], 
            user_type: json['user_type'],
            userid: json['userid'], 
            family: json['family'] != null? UserModel.fromJson(json['family']):null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['updated_at'] = this.updated_at;
        data['userid'] = this.userid;
        data['description'] = this.description;
        data['familyid'] = this.familyid;
        if (this.orderlist != null) {
            data['orderlist'] = this.orderlist.map((v) => v.toJson()).toList();
        }
        data['orderid'] = this.orderid;
        data['status'] = this.status;
        data['status_id'] = this.status_id;
        data['user_type'] = this.user_type;
        return data;
    }
}
class OrderList{
  int id;
  int orderid;
  String title;
  int quantity;
  String created_at;
  String updated_at;
  OrderList({
    this.id,
    this.orderid,
    this.title,
    this.quantity,
    this.created_at,
    this.updated_at});
  factory OrderList.fromJson(Map<String, dynamic> json) {
    return OrderList(
      id: json['id'],
      orderid: json['orderid'],
      title: json['title'],
      quantity: json['quantity'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['orderid'] = this.orderid;
    data['title'] = this.title;
    data['quantity'] = this.quantity;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
class Status {
    int id;
    String title;
    String color;

    Status({this.id, this.title,this.color});

    factory Status.fromJson(Map<String, dynamic> json) {
        return Status(
            id: json['id'], 
            title: json['title'], 
            color: json['color'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['title'] = this.title;
        data['color'] = this.color;
        return data;
    }
}