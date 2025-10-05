import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../error/error_messages.dart';
import '../../../../error/failures.dart';
import '../../../../utils/app_strings.dart';
import '../../../data/models/response/promotions_response.dart';
import '../../../domain/use_cases/promotions_use_case/promotions_use_case.dart';

part 'promotions_state.dart';
class PromotionsCubit extends Cubit<PromotionsState> {
  final GetPromotionsUseCase getPromotionsUseCase;
  PromotionsCubit({required this.getPromotionsUseCase}) : super(PromotionsInitial());

  Future<void> fetchPromotions() async {
    emit(PromotionsLoading());
    final result = await getPromotionsUseCase();
    result.fold(
          (failure) {
        if(failure is ConnectionFailure){
          emit(PromotionsError(message: ErrorMessages().mapFailureToMessage(failure) ?? ""));
        }else if(failure is AuthorizedFailure) {
          emit(PromotionsError(message: AppStrings.unAuthorizedDes));
          return;
        }else if (failure is ServerFailure){
          emit(PromotionsError(message: failure.errorResponse.errorDescription ?? AppStrings.somethingWentWrong));
        }else {
          emit(PromotionsError(message: AppStrings.somethingWentWrong));
        }

      },
          (promotions) => emit(PromotionsLoaded(promotions: promotions)),
    );
  }
}
