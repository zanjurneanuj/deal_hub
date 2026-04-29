import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/session_manager.dart';
import '../../../core/widgets/deal_card.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../auth/screens/login_screen.dart';
import '../../interests/bloc/interest_bloc.dart';
import '../../interests/bloc/interest_event.dart';
import '../../interests/bloc/interest_state.dart';
import '../../interests/screens/my_interests_screen.dart';
import '../bloc/deal_bloc.dart';
import '../bloc/deal_event.dart';
import '../bloc/deal_state.dart';
import 'deal_detail_screen.dart';

class DealListScreen extends StatefulWidget {
  const DealListScreen({Key? key}) : super(key: key);

  @override
  State<DealListScreen> createState() => _DealListScreenState();
}

class _DealListScreenState extends State<DealListScreen> {
  String _selectedRisk = 'All';
  String _selectedIndustry = 'All';
  RangeValues _roiRange = const RangeValues(0, 100);

  @override
  void initState() {
    super.initState();
    context.read<DealBloc>().add(LoadDeals());
    context.read<InterestBloc>().add(LoadInterests());
  }

  void _dispatchFilter({String? searchQuery}) {
    context.read<DealBloc>().add(FilterDeals(
      searchQuery: searchQuery,
      riskLevel: _selectedRisk == 'All' ? null : _selectedRisk,
      industry: _selectedIndustry == 'All' ? null : _selectedIndustry,
      minROI: _roiRange.start,
      maxROI: _roiRange.end,
    ));
  }

  void _resetFilters() {
    setState(() {
      _selectedRisk = 'All';
      _selectedIndustry = 'All';
      _roiRange = const RangeValues(0, 100);
    });
    context.read<DealBloc>().add(LoadDeals());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Welcome 👋',
                style: TextStyle(fontSize: 15, color: Colors.grey)),
            SizedBox(height: 4),
            Text('Investment Deals',
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          // Interests badge
          BlocBuilder<InterestBloc, InterestState>(
            builder: (context, state) {
              final count = state is InterestLoaded
                  ? state.interestedDeals.length
                  : 0;
              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        shape: BoxShape.circle),
                    child: IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.red,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const MyInterestsScreen()),
                      ),
                    ),
                  ),
                  if (count > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        constraints: const BoxConstraints(
                            minWidth: 18, minHeight: 18),
                        child: Text(
                          '$count',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),

          // Logout
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
                color: Colors.grey.shade100, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.logout),
              color: Colors.black87,
              onPressed: () async {
                await SessionManager.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                );
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
              height: 1,
              color: Colors.grey.withValues(alpha: 0.2)),
        ),
      ),

      body: BlocBuilder<DealBloc, DealState>(
        builder: (context, state) {
          if (state is DealLoading) {
            return const LoadingWidget(
                message: 'Loading investment deals...');
          }

          if (state is DealError) {
            return AppErrorWidget(
              message: state.message,
              onRetry: () =>
                  context.read<DealBloc>().add(LoadDeals()),
            );
          }

          if (state is DealLoaded) {
            final industries = <String>[
              'All',
              ...state.allDeals.map((d) => d.industry).toSet(),
            ];

            return Column(
              children: [
                // ── Search ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by company...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => _dispatchFilter(searchQuery: v),
                  ),
                ),

                // ── Filter panel ──────────────────────────────────
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── Risk + Industry in ONE scrollable row ──
                      SizedBox(
                        height: 36,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            // Risk label + chips
                            _labelChip('Risk:'),
                            ...[
                              'All',
                              'Low',
                              'Medium',
                              'High'
                            ].map((item) => _chip(
                              label: item,
                              selected: _selectedRisk == item,
                              onTap: () {
                                setState(
                                        () => _selectedRisk = item);
                                _dispatchFilter();
                              },
                            )),

                            // Divider
                            const VerticalDivider(
                                width: 20, thickness: 1),

                            // Industry label + chips
                            _labelChip('Industry:'),
                            ...industries.map((item) => _chip(
                              label: item,
                              selected:
                              _selectedIndustry == item,
                              onTap: () {
                                setState(() =>
                                _selectedIndustry = item);
                                _dispatchFilter();
                              },
                            )),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // ── ROI Range ─────────────────────────────
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('ROI Range',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                          Text(
                            '${_roiRange.start.round()}% – ${_roiRange.end.round()}%',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: _roiRange,
                        min: 0,
                        max: 100,
                        divisions: 20,
                        labels: RangeLabels(
                          '${_roiRange.start.round()}%',
                          '${_roiRange.end.round()}%',
                        ),
                        onChanged: (v) =>
                            setState(() => _roiRange = v),
                        onChangeEnd: (_) => _dispatchFilter(),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ── List / Empty state ────────────────────────────
                if (state.filteredDeals.isEmpty)
                  Expanded(
                    child: EmptyStateWidget(
                      icon: Icons.search_off,
                      title: 'No Deals Found',
                      subtitle: 'Try adjusting your filters.',
                      actionLabel: 'Reset Filters',
                      onAction: _resetFilters,
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: state.filteredDeals.length,
                      itemBuilder: (_, i) {
                        final deal = state.filteredDeals[i];
                        return DealCard(
                          deal: deal,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DealDetailScreen(deal: deal)),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  // Small bold label before a chip group
  Widget _labelChip(String text) => Padding(
    padding: const EdgeInsets.only(right: 6, left: 4),
    child: Center(
      child: Text(text,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold)),
    ),
  );

  // Individual chip
  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) =>
      Padding(
        padding: const EdgeInsets.only(right: 6),
        child: ChoiceChip(
          label: Text(label, style: const TextStyle(fontSize: 12)),
          selected: selected,
          onSelected: (_) => onTap(),
          visualDensity: VisualDensity.compact,
          padding: const EdgeInsets.symmetric(horizontal: 4),
        ),
      );
}