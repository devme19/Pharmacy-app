import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class UpdateOrderUseCase implements UseCase<bool,Params>{
  final NavidAppRepository repository;
  UpdateOrderUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.updateOrder(params.id, params.body);
  }

}