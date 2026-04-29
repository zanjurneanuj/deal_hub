import 'package:equatable/equatable.dart';
import '../../../data/models/deal_model.dart';

abstract class DealState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DealInitial extends DealState {}

class DealLoading extends DealState {}

class DealLoaded extends DealState {
  final List<Deal> allDeals;
  final List<Deal> filteredDeals;

  DealLoaded({
    required this.allDeals,
    required this.filteredDeals,
  });

  @override
  List<Object?> get props => [allDeals, filteredDeals];
}

class DealError extends DealState {
  final String message;
  DealError(this.message);

  @override
  List<Object?> get props => [message];
}