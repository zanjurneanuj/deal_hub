import 'package:equatable/equatable.dart';
import '../../../data/models/deal_model.dart';
abstract class InterestState extends Equatable {
  const InterestState();
  @override
  List<Object?> get props => [];
}
class InterestLoading extends InterestState {}
class InterestLoaded extends InterestState {
  final List<Deal> interestedDeals;
  const InterestLoaded(this.interestedDeals);
  @override
  List<Object?> get props => [interestedDeals];
}
class InterestError extends InterestState {
  final String message;
  const InterestError(this.message);
  @override
  List<Object?> get props => [message];
}