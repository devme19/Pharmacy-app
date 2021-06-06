import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class SetFontSizeUseCase implements UseCase<bool,Params>{
  final NavidAppRepository repository;
  SetFontSizeUseCase({this.repository});

  @override
  Future<Either<Failure, bool>> call(Params params) {
    return repository.setFontSize(double.parse(params.value));
  }

}