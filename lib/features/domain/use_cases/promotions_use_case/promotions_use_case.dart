import 'package:dartz/dartz.dart';
import '../../../../error/failures.dart';
import '../../../data/models/response/promotions_response.dart';
import '../../repositories/repository.dart';

class GetPromotionsUseCase {
  final Repository repository;
  GetPromotionsUseCase(this.repository);

  Future<Either<Failure, List<PromotionsResponse>>> call() {
    return repository.getPromotions();
  }
}
