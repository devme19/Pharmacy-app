import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class LogOutUseCase implements UseCase<bool,NoParams>{
  final NavidAppRepository repository;
  LogOutUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(NoParams params) {
    return repository.logOut();
  }

}