import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/status_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetStatusUseCase implements UseCase<StatusEntity,Params>{
  final NavidAppRepository repository;
  GetStatusUseCase({this.repository});

  @override
  Future<Either<Failure, StatusEntity>> call(Params params) {
    return repository.getStatus(params.boolValue);
  }
}