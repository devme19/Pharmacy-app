import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/detail_order_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetDetailOrderUseCase implements UseCase<DetailOrderEntity,Params>{
  final NavidAppRepository repository;
  GetDetailOrderUseCase({this.repository});

  @override
  Future<Either<Failure, DetailOrderEntity>> call(Params params) {
    return repository.getDetailOrder(params.id);
  }

}