part of 'promotions_cubit.dart';

abstract class PromotionsState {}

class PromotionsInitial extends PromotionsState {}

class PromotionsLoading extends PromotionsState {}

class PromotionsLoaded extends PromotionsState {
  final List<PromotionsResponse> promotions;
  PromotionsLoaded({required this.promotions});
}

class PromotionsError extends PromotionsState {
  final String message;
  PromotionsError({required this.message});
}
