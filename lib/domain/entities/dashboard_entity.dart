import 'package:navid_app/data/model/dashboard_model.dart';

class DashboardEntity{
  int count_delivered;
  int count_order;
  int count_pending;
  List<Family> family;
  bool status;

  DashboardEntity({this.count_delivered,this.count_order,this.count_pending,this.family,this.status});
}