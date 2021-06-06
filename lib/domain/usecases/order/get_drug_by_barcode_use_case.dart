import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/barcode_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetDrugByBarCodeUseCase implements UseCase<BarCodeEntity, Params>{
  final NavidAppRepository repository;
  GetDrugByBarCodeUseCase({this.repository});

  @override
  Future<Either<Failure, BarCodeEntity>> call(Params params) {
   return repository.getDrugByBarCode(params.value);
  }
}