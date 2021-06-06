import 'package:navid_app/data/model/drug_model.dart';

class DrugEntity{
  List<Drug> drugs;
  int page;
  int status;
  int total;
  DrugEntity({
    this.drugs,
    this.page,
    this.status,
    this.total
  });
}