import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/data/model/drug_model.dart';
import 'package:navid_app/data/model/user_model.dart';
import 'package:navid_app/domain/entities/barcode_entity.dart';
import 'package:navid_app/domain/entities/drug_entity.dart';
import 'package:navid_app/domain/usecases/order/add_order_use_case.dart';
import 'package:navid_app/domain/usecases/order/delete_order_use_case.dart';
import 'package:navid_app/domain/usecases/order/get_drug_by_barcode_use_case.dart';
import 'package:navid_app/domain/usecases/order/get_drugs_usecase.dart';
import 'package:navid_app/domain/usecases/order/update_order_use_case.dart';
import 'package:navid_app/domain/usecases/user/get_accounts_use_case.dart';
import 'package:navid_app/presentation/controllers/history_controller.dart';
import 'package:navid_app/presentation/navigation/navid_app.dart';
import 'package:navid_app/presentation/pages/widget/alert_dialog.dart';
import 'package:navid_app/presentation/pages/widget/medicine_widget.dart';
import 'package:navid_app/utils/helper.dart';
import 'package:navid_app/utils/state_status.dart';

class PrescriptionController extends GetxController{
  final GlobalKey<AnimatedListState> listKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  RxList medicineList = [].obs;
  DrugEntity drugEntity = new DrugEntity();
  BarCodeEntity barCodeEntity = BarCodeEntity();
  List<Drug> drugsList = [];
  RxBool selectUserVisible = true.obs;
  var getAccountsState = StateStatus.INITIAL.obs;
  var updateOderState = StateStatus.INITIAL.obs;
  var addOderState = StateStatus.INITIAL.obs;
  var getDrugsState = StateStatus.INITIAL.obs;
  var deleteOrderState = StateStatus.INITIAL.obs;
  var getDrugByBarcodeState = StateStatus.INITIAL.obs;
  List<UserModel> accounts;
  RxInt listSize = 0.obs;
  RxString accountName ="".obs;
  RxBool edit = false.obs;
  RxBool visibleSearch = false.obs;
  RxBool errorVisibility = false.obs;
  int pageIndex = 0;
  getDrugByBarCode(String parameters,ValueChanged<MedicineWidget> parentAction){
    getDrugByBarcodeState.value = StateStatus.LOADING;
    GetDrugByBarCodeUseCase getDrugByBarCodeUseCase = Get.find();
    getDrugByBarCodeUseCase.call(Params(value: parameters)).then((response) {
      if(response.isRight){
        getDrugByBarcodeState.value = StateStatus.SUCCESS;

        barCodeEntity = response.right;
        medicineList.add(
            MedicineWidget(removeAction: remove,editAction: parentAction,title: barCodeEntity.data.title,quantity: '1',)
        );
      }
      else if(response.isLeft){
        getDrugByBarcodeState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    });
  }
  getAccounts(ValueChanged<bool> done){
    getAccountsState.value = StateStatus.LOADING;
    GetAccountsUseCase getAccountsUseCase = Get.find();
    getAccountsUseCase.call(NoParams()).then((response){
      if(response.isRight) {
        {
          getAccountsState.value = StateStatus.SUCCESS;
          accounts = new List();
          accounts.addAll(response.right.data);
          accountName.value = accounts[0].name+" "+accounts[0].family;
          if(done != null) done(true);
        }
      } else
      if(response.isLeft)
       {
         getAccountsState.value = StateStatus.ERROR;
       }
    });
  }
  setAccountName(String name){
    accountName.value = name;
  }
  changeVisibility(bool visible){
    selectUserVisible.value = visible;
  }
  changeErrorVisibility(bool visible){
    errorVisibility.value = visible;
  }
  addOrder(Map body,ValueChanged<bool> clearDescAction){
    addOderState.value = StateStatus.LOADING;
    AddOrderUseCase addOrderUseCase = Get.find();
    addOrderUseCase.call(Params(body: body)).then((response) {
      if(response.isRight){
        addOderState.value = StateStatus.SUCCESS;
        Get.toNamed(NavidAppRoutes.detailOrderPage,arguments: [response.right.id.toString(),true,null,null]).then((value){
          medicineList.clear();
          selectUserVisible.value = true;
          clearDescAction(true);
        });
      }else if(response.isLeft){
        addOderState.value = StateStatus.ERROR;
      }
    });
  }
  getDrugs(String parameters){
    getDrugsState.value = StateStatus.LOADING;
    GetDrugsUseCase getDrugsUseCase = Get.find();
    getDrugsUseCase.call(Params(value: parameters)).then((response) {
      if(response.isRight){
        getDrugsState.value = StateStatus.SUCCESS;
        drugEntity=response.right;
        drugsList.addAll(drugEntity.drugs);
        listSize.value = drugsList.length;
        // if(listSize.value == 0)
        //   listSize.value = -1;
        pageIndex = drugEntity.page;
        // parentAction(true);
      }else if(response.isLeft){
        getDrugsState.value = StateStatus.ERROR;
      }
    });
  }
  addItem(String title,String quantity,ValueChanged<MedicineWidget> parentAction) {
    // drugsList.remove(drugsList.singleWhere((i) => i.title == title));
    // listSize.value = drugsList.length;
    medicineList.add(
        MedicineWidget(removeAction: remove,editAction: parentAction,title: title,quantity: quantity,)
    );
  }
  editItem(MedicineWidget medicineItem,String title,String quantity,ValueChanged<MedicineWidget> parentAction){
    final index = medicineList.indexWhere((element) =>
    element == medicineItem);
    medicineList[index]=MedicineWidget(removeAction: remove,editAction: parentAction,title: title,quantity: quantity,);
  }
  updateOrder(String id,Map body,ValueChanged<String> parentUpdate){
    updateOderState.value = StateStatus.LOADING;
    UpdateOrderUseCase updateOrderUseCase = Get.find();
    updateOrderUseCase.call(Params(id: id,body: body)).then((response) {
      if(response.isRight)
        {
          updateOderState.value = StateStatus.SUCCESS;
          parentUpdate(id);
          Get.back();
        }
      else
        if(response.isLeft)
          updateOderState.value = StateStatus.ERROR;
    });
  }
  deleteOrder(String id,ValueChanged<String> parentAction){
    deleteOrderState.value = StateStatus.LOADING;
    DeleteOrderUseCase deleteOrderUseCase = Get.find();
    deleteOrderUseCase.call(Params(id: id)).then((response){
      if(response.isRight)
        {
          deleteOrderState.value = StateStatus.SUCCESS;
          parentAction(id);
          // HistoryController historyController = Get.put(HistoryController());
          // historyController.orders.remove(historyController.orders.singleWhere((i) => i.id.toString() == id));
          Get.back(result: true);
          Get.back();
        }
      else if(response.isLeft) {
        deleteOrderState.value = StateStatus.ERROR;
        errorAction(response.left);
      }
    } );
  }
  remove(MedicineWidget item){
    medicineList.remove(item);
  }
  // removeItem(MedicineWidget item) {
  //   int  index;
  //   for(int i=0;i<medicineList.length;i++)
  //     if(item == medicineList[i]) {
  //       index = i;
  //       break;
  //     }
  //   medicineList.remove(item);
  //   listKey.currentState.removeItem(
  //     index,
  //         (BuildContext context, Animation<double> animation) {
  //       return FadeTransition(
  //         opacity:
  //         CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0)),
  //         child: SizeTransition(
  //           sizeFactor:
  //           CurvedAnimation(parent: animation, curve: Interval(0.0, 1.0)),
  //           axisAlignment: 0.0,
  //           child: buildItem(item),
  //         ),
  //       );
  //     },
  //     duration: Duration(milliseconds: 600),
  //   );
  // }
  // Widget buildItem(MedicineWidget medicine) {
  //   return medicine;
  // }
}