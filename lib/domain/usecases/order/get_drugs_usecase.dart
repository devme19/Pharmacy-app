import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/drug_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetDrugsUseCase implements UseCase<DrugEntity,Params>{
  final NavidAppRepository repository;
  GetDrugsUseCase({this.repository});

  @override
  Future<Either<Failure, DrugEntity>> call(Params params) {
    return repository.getDrugs(params.value);
  }
}