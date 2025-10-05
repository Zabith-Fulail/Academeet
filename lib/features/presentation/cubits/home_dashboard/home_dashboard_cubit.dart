import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../error/error_messages.dart';
import '../../../../error/failures.dart';
import '../../../../utils/app_strings.dart';
import '../../../data/models/response/promotions_response.dart';
import '../../../domain/use_cases/promotions_use_case/promotions_use_case.dart';

part 'home_dashboard_state.dart';

class HomeDashboardCubit extends Cubit<HomeDashboardState> {
  final GetPromotionsUseCase getPromotionsUseCase;

  HomeDashboardCubit({required this.getPromotionsUseCase})
      : super(HomeDashboardInitial());

  /// Fetch promotions for the dashboard
  Future<void> fetchPromotions() async {
    emit(HomeDashboardLoading());
    final result = await getPromotionsUseCase();
    result.fold(
          (failure) {
        if(failure is ConnectionFailure){
          emit(HomeDashboardPromotionsError(message: ErrorMessages().mapFailureToMessage(failure) ?? ""));
        }else if(failure is AuthorizedFailure) {
          emit(HomeDashboardPromotionsError(message: AppStrings.unAuthorizedDes));
          return;
        }else if (failure is ServerFailure){
          emit(HomeDashboardPromotionsError(message: failure.errorResponse.errorDescription ?? AppStrings.somethingWentWrong));
        }else {
          emit(HomeDashboardPromotionsError(message: AppStrings.somethingWentWrong));
        }

      },
          (promotions) => emit(HomeDashboardPromotionsLoaded(promotions: promotions)),
    );
  }
}
