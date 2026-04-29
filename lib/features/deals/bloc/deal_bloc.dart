import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/deal_model.dart';
import '../../../data/repositories/deal_repository.dart';
import 'deal_event.dart';
import 'deal_state.dart';

class DealBloc extends Bloc<DealEvent, DealState> {
  final DealRepository repository;

  List<Deal> _allDeals = [];

  // Persist last search query so chip changes don't wipe it
  String _lastSearchQuery = '';

  DealBloc(this.repository) : super(DealInitial()) {
    on<LoadDeals>(_onLoadDeals);
    on<FilterDeals>(_onFilterDeals);
    on<ShowInterest>(_onShowInterest);
  }

  Future<void> _onLoadDeals(
      LoadDeals event,
      Emitter<DealState> emit,
      ) async {
    emit(DealLoading());
    try {
      _allDeals = await repository.getDeals();
      _lastSearchQuery = '';           // reset search on full reload
      emit(DealLoaded(
        allDeals: _allDeals,
        filteredDeals: _allDeals,
      ));
    } catch (e) {
      emit(DealError('Failed to load deals'));
    }
  }

  void _onFilterDeals(FilterDeals event, Emitter<DealState> emit) {
    if (state is! DealLoaded) return;

    // Persist search query — if event sends null, keep the last one
    if (event.searchQuery != null) {
      _lastSearchQuery = event.searchQuery!;
    }

    List<Deal> filtered = List.from(_allDeals);

    // Search
    if (_lastSearchQuery.isNotEmpty) {
      filtered = filtered
          .where((d) => d.companyName
          .toLowerCase()
          .contains(_lastSearchQuery.toLowerCase()))
          .toList();
    }

    // Risk level
    if (event.riskLevel != null) {
      filtered = filtered
          .where((d) => d.riskLevel == event.riskLevel)
          .toList();
    }

    // Industry
    if (event.industry != null) {
      filtered = filtered
          .where((d) => d.industry == event.industry)
          .toList();
    }

    // ROI range
    if (event.minROI != null && event.maxROI != null) {
      filtered = filtered
          .where((d) =>
      d.expectedROI >= event.minROI! &&
          d.expectedROI <= event.maxROI!)
          .toList();
    }

    emit(DealLoaded(
      allDeals: _allDeals,
      filteredDeals: filtered,
    ));
  }

  void _onShowInterest(ShowInterest event, Emitter<DealState> emit) {
    // Handled by InterestBloc — nothing to emit here
  }
}