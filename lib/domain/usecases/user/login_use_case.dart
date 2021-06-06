import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/login_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class LoginUseCase implements UseCase<IdentityEntity,Params>{
  final NavidAppRepository repository;
  LoginUseCase({this.repository});

  @override
  Future<Either<Failure, IdentityEntity>> call(Params params) {
    return repository.login(params.body);
  }

}