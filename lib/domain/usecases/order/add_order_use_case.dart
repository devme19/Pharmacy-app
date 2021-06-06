import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/add_order_response_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class AddOrderUseCase implements UseCase<AddOrderResponseEntity,Params>{
  final NavidAppRepository repository;
  AddOrderUseCase({this.repository});

  @override
  Future<Either<Failure, AddOrderResponseEntity>> call(Params params) {
    return repository.addOrder(params.body);
  }



}