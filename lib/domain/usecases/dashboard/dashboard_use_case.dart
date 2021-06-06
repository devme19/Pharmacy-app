import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/dashboard_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class DashboardUseCase implements UseCase<DashboardEntity,NoParams>{
  final NavidAppRepository repository;
  DashboardUseCase({this.repository});

  @override
  Future<Either<Failure, DashboardEntity>> call(NoParams params) {
    return repository.getDashboard();
  }

}