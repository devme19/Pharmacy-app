import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/dependents_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetAccountsUseCase implements UseCase<DependentsEntity,NoParams>{
  final NavidAppRepository repository;
  GetAccountsUseCase({this.repository});

  @override
  Future<Either<Failure, DependentsEntity>> call(NoParams params) {
    return repository.getAccounts();
  }

}