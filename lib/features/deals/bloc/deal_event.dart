import 'package:equatable/equatable.dart';

abstract class DealEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Load all deals
class LoadDeals extends DealEvent {}

/// Filter deals
class FilterDeals extends DealEvent {
  final String? searchQuery;
  final String? riskLevel;
  final String? industry;
  final double? minROI;
  final double? maxROI;

  FilterDeals({
    this.searchQuery,
    this.riskLevel,
    this.industry,
    this.minROI,
    this.maxROI,
  });
}
/// Show interest in a deal
class ShowInterest extends DealEvent {
  final String dealId;

  ShowInterest(this.dealId);

  @override
  List<Object?> get props => [dealId];
}