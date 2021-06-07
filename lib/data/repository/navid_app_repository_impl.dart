import 'package:either_type/src/either.dart';
import 'package:flutter/material.dart';
import 'package:navid_app/core/error/exceptions.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/data/datasources/local/navid_app_local_data_source.dart';
import 'package:navid_app/data/datasources/remote/navid_app_remote_data_source.dart';
import 'package:navid_app/data/model/add_order_response_model.dart';
import 'package:navid_app/data/model/barcode_model.dart';
import 'package:navid_app/data/model/dashboard_model.dart';
import 'package:navid_app/data/model/dependents_model.dart';
import 'package:navid_app/data/model/detail_order_model.dart';
import 'package:navid_app/data/model/drug_model.dart';
import 'package:navid_app/data/model/identity_model.dart';
import 'package:navid_app/data/model/non_payment_model.dart';
import 'package:navid_app/data/model/order_model.dart';
import 'package:navid_app/data/model/status_model.dart';
import 'package:navid_app/data/model/user_model.dart';
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
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class NavidAppRepositoryImpl implements NavidAppRepository{
  final NavidAppLocalDataSource localDataSource;
  final NavidAppRemoteDataSource remoteDataSource;

  NavidAppRepositoryImpl({
    this.localDataSource,
    this.remoteDataSource,
  });

  ///////////////// User /////////////////
  @override
  Future<Either<Failure, UserEntity>> isLogin() async{
    try{
      if(localDataSource.getToken() == null)
        return Left(null);
      final response = await remoteDataSource.get<UserModel,Null>("info");
      localDataSource.saveUserInfo(response);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, NonPaymentEntity>> getReason() async{
    try{
      final response = await remoteDataSource.get<NonPaymentModel,Null>("payment");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  @override
  Future<Either<Failure, UserEntity>> getUserInfo() async{
   try{
     UserModel userInfoModel = localDataSource.getUserInfo();
     if(userInfoModel != null)
       return Right(userInfoModel);
     else
      {
        final response =
            await remoteDataSource.get<UserModel, Null>("info");
        localDataSource.saveUserInfo(response);
        return Right(response);
      }
    }on ServerException catch(e){
     return Left(ServerFailure(errorCode: e.errorCode));
   }
  }

  @override
  Future<Either<Failure, IdentityEntity>> login(Map body) async{
    try{
      final response = await remoteDataSource.post<IdentityModel,Null>(body, "login");
      localDataSource.saveToken(response.token);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> logOut()async{
    try{
      final response = localDataSource.logOut();
      return Right(response);
    }on CacheException catch(e){
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, IdentityEntity>> register(Map body) async{
    try{
      final response = await remoteDataSource.post<IdentityModel,Null>(body, "register");
      localDataSource.saveToken(response.token);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> updateUser(Map body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "updateUser");
      localDataSource.removeUserInfo();
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> changePassword(Map body) async{
   try{
     final response = await remoteDataSource.post<bool,Null>(body, "changePassword");
     return Right(response);
   }on ServerException catch(e){
     return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
   }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(Map body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "user/reset");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  //////////////////// order //////////////////////
  @override
  Future<Either<Failure, AddOrderResponseModel>> addOrder(Map body) async{
    try{
      final response = await remoteDataSource.post<AddOrderResponseModel,Null>(body, "addorder");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, OrderEntity>> getOrders(String parameters) async{
    try{
      final response = await remoteDataSource.get<OrderModel, Null>("listorder$parameters");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, DetailOrderEntity>> getDetailOrder(String id) async{
    try{
      final response = await remoteDataSource.get<DetailOrderModel,Null>("showOrder/$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> updateOrder(String id, Map body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "updateorderlist/$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> deleteOrder(String id) async{
    try{
      final response = await remoteDataSource.get<bool,Null>("deleteorder/$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, DrugEntity>> getDrugs(String parameters) async{
    try{
      final response = await remoteDataSource.get<DrugModel,Null>("drug$parameters");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, BarCodeEntity>> getDrugByBarCode(String parameters) async{
    try{
      final response = await remoteDataSource.get<BarCodeModel,Null>("drug/view?code=$parameters");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  /////////////////// Family /////////////////////////
  @override
  Future<Either<Failure, DependentsEntity>> getDependents() async{
    try{
      final response = await remoteDataSource.get<DependentsModel,Null>("listFamily");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> addDependent(Map body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "addfamily");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getDependent(String id) async{
    try{
      final response = await remoteDataSource.get<UserModel,Null>("showFamily/?id=$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> updateDependent(String id, Map body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "updateFamily/$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, bool>> deleteDependent(String id) async{
    try{
      final response = await remoteDataSource.get<bool,Null>("destroyFamily/$id");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
  @override
  Future<Either<Failure, DependentsEntity>> getAccounts() async{
    try{
      final response = await remoteDataSource.get<DependentsModel,Null>("mylist");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }
 /////////////////////// Setting ///////////////////////////
  @override
  Future<Either<Failure, double>> getFontSize() async{
    try{
      final response = localDataSource.getFontSize();
      return Right(response);
    }on ServerException catch(e){
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setFontSize(double size) async{
    try{
      final response = localDataSource.setFontSize(size);
      return Right(response);
    }on ServerException catch(e){
      return Left(CacheFailure());
    }
  }
  @override
  Future<Either<Failure, bool>> getMode() async{
    try{
      final response = localDataSource.getMode();
      return Right(response);
    }on ServerException catch(e){
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> setMode(bool darkMode) async{
    try{
      final response = localDataSource.setMode(darkMode);
      return Right(response);
    }on ServerException catch(e){
      return Left(CacheFailure());
    }
  }
 //////////////////// Dashboard /////////////////////
  @override
  Future<Either<Failure, DashboardEntity>> getDashboard() async{
    try{
      final response  = await remoteDataSource.get<DashboardModel,Null>("dashboard");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }

  //////////////////// Init ///////////////////////
  @override
  Future<Either<Failure, StatusEntity>> getStatus(bool isSplash) async{
    try{
      if(!isSplash){
        StatusModel statusModel = localDataSource.getStatus();
        if(statusModel != null)
          return Right(statusModel);
      }
      final response = await remoteDataSource.get<StatusModel, Null>("liststatus");
      localDataSource.saveStatus(response);
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode));
    }
  }
  /////////////////// contact us ////////////////////
  @override
  Future<Either<Failure, bool>> contactUs(Map body) async{
    try{
      final response = await remoteDataSource.post<bool,Null>(body, "contact");
      return Right(response);
    }on ServerException catch(e){
      return Left(ServerFailure(errorCode: e.errorCode,errorMessage: e.errorMessage));
    }
  }










}