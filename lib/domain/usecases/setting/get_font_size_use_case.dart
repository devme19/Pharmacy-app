import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetFontSizeUseCase implements UseCase<double,NoParams>{
  final NavidAppRepository repository;
  GetFontSizeUseCase({this.repository});

  @override
  Future<Either<Failure, double>> call(NoParams params) {
    return repository.getFontSize();
  }

}