import 'package:either_type/src/either.dart';
import 'package:navid_app/core/error/failures.dart';
import 'package:navid_app/core/usecase/usecase.dart';
import 'package:navid_app/domain/entities/non_payment_entity.dart';
import 'package:navid_app/domain/repository/navid_app_repository.dart';

class GetNonPaymentReasonUseCase implements UseCase<NonPaymentEntity,NoParams>{
  final NavidAppRepository repository;
  GetNonPaymentReasonUseCase({this.repository});

  @override
  Future<Either<Failure, NonPaymentEntity>> call(NoParams params) {
    return repository.getReason();
  }
}