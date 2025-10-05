part of 'home_dashboard_cubit.dart';

abstract class HomeDashboardState {
}

class HomeDashboardInitial extends HomeDashboardState {}

class HomeDashboardLoading extends HomeDashboardState {}

class HomeDashboardPromotionsLoaded extends HomeDashboardState {
  final List<PromotionsResponse> promotions;

  HomeDashboardPromotionsLoaded({required this.promotions});

}

class HomeDashboardPromotionsError extends HomeDashboardState {
  final String message;

  HomeDashboardPromotionsError({required this.message});
}
