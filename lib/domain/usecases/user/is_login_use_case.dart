import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/user_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class IsLoginUseCase implements UseCase<UserEntity,NoParams>{
  final NavidAppRepository repository;
  IsLoginUseCase({
    this.repository
  });

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.isLogin();
  }

}