import 'package:flutter_bloc/flutter_bloc.dart';
import '../../deals/bloc/deal_bloc.dart';
import '../../../data/models/deal_model.dart';
import '../../deals/bloc/deal_state.dart';
import 'interest_event.dart';
import 'interest_state.dart';
class InterestBloc extends Bloc<InterestEvent, InterestState> {
  final DealBloc dealBloc;
  final List<String> _interestedIds = [];
  InterestBloc(this.dealBloc) : super(InterestLoading()) {
    on<LoadInterests>(_onLoad);
    on<AddInterest>(_onAdd);
    on<RemoveInterest>(_onRemove);
  }
  void _onLoad(LoadInterests event, Emitter<InterestState> emit) {
    final dealState = dealBloc.state;
    if (dealState is DealLoaded) {
      final deals = dealState.allDeals
          .where((deal) => _interestedIds.contains(deal.id))
          .toList();
      emit(InterestLoaded(deals));
    } else {
      emit(const InterestLoaded([]));
    }
  }
  void _onAdd(AddInterest event, Emitter<InterestState> emit) {
    _interestedIds.add(event.dealId);
    add(LoadInterests()); 
  }
  void _onRemove(RemoveInterest event, Emitter<InterestState> emit) {
    _interestedIds.remove(event.dealId);
    add(LoadInterests());
  }
}