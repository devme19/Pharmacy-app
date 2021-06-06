import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/order_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetOrdersUseCase implements UseCase<OrderEntity,Params>{
  final NavidAppRepository repository;
  GetOrdersUseCase({this.repository});

  @override
  Future<Either<Failure, OrderEntity>> call(Params params) {
   return repository.getOrders(params.value);
  }
}