import 'package:either_type/either_type.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/domain/entities/add_order_response_entity.dart';
import 'package:navid_app/domain/entities/barcode_entity.dart';
import 'package:navid_app/domain/entities/dashboard_entity.dart';
import 'package:navid_app/domain/entities/dependents_entity.dart';
import 'package:navid_app/domain/entities/detail_order_entity.dart';
import 'package:navid_app/domain/entities/drug_entity.dart';
import 'package:navid_app/domain/entities/login_entity.dart';
import 'package:navid_app/domain/entities/non_payment_entity.dart';
import 'package:navid_app/domain/entities/order_entity.dart';
import 'package:navid_app/domain/entities/status_entity.dart';
import 'package:navid_app/domain/entities/user_entity.dart';

abstract class NavidAppRepository{
  ////////////// User ////////////
  Future<Either<Failure,UserEntity>> isLogin();
  Future<Either<Failure,UserEntity>> getUserInfo();
  Future<Either<Failure,bool>> updateUser(Map body);
  Future<Either<Failure,IdentityEntity>> login(Map body);
  Future<Either<Failure,IdentityEntity>> register(Map body);
  Future<Either<Failure,bool>> logOut();
  Future<Either<Failure,bool>> changePassword(Map body);
  Future<Either<Failure,bool>> resetPassword(Map body);
  Future<Either<Failure,NonPaymentEntity>> getReason();
  ///////////// order /////////////
  Future<Either<Failure,AddOrderResponseEntity>> addOrder(Map body);
  Future<Either<Failure,OrderEntity>> getOrders(String parameters);
  Future<Either<Failure,DetailOrderEntity>> getDetailOrder(String id);
  Future<Either<Failure,bool>> updateOrder(String id,Map body);
  Future<Either<Failure,bool>> deleteOrder(String id);
  Future<Either<Failure,DrugEntity>> getDrugs(String parameters);
  Future<Either<Failure,BarCodeEntity>> getDrugByBarCode(String parameters);
  ///////////// family /////////////
  Future<Either<Failure,DependentsEntity>> getDependents();
  Future<Either<Failure,UserEntity>> getDependent(String id);
  Future<Either<Failure,bool>> addDependent(Map body);
  Future<Either<Failure,bool>> updateDependent(String id,Map body);
  Future<Either<Failure,DependentsEntity>> getAccounts();
  ///////////// setting /////////////
  Future<Either<Failure,double>> getFontSize();
  Future<Either<Failure,bool>> setFontSize(double size);
  Future<Either<Failure,bool>> setMode(bool darkMode);
  Future<Either<Failure,bool>> getMode();
  //////////// dashboard ////////////
  Future<Either<Failure,DashboardEntity>> getDashboard();
  //////////// init   /////////////////
  Future<Either<Failure,StatusEntity>> getStatus(bool isSplash);
  /////////// contact us //////////////
  Future<Either<Failure,bool>> contactUs(Map body);
  }