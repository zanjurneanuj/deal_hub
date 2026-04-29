import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/widgets/deal_card.dart';
import '../../../core/widgets/loading_widget.dart';

import '../bloc/interest_bloc.dart';
import '../bloc/interest_event.dart';
import '../bloc/interest_state.dart';

class MyInterestsScreen extends StatefulWidget {
  const MyInterestsScreen({Key? key}) : super(key: key);

  @override
  State<MyInterestsScreen> createState() => _MyInterestsScreenState();
}

class _MyInterestsScreenState extends State<MyInterestsScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<InterestBloc>().add(LoadInterests());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Interests')),
      body: BlocBuilder<InterestBloc, InterestState>(
        builder: (context, state) {
          if (state is InterestLoading) {
            return const LoadingWidget(message: 'Loading your interests...');
          }



          if (state is InterestLoaded) {
            // Search filter only — Risk/Industry/ROI live in DealListScreen
            final deals = state.interestedDeals
                .where((d) => d.companyName
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()))
                .toList();

            return Column(
              children: [
                // ── Search ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search your interests...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (v) => setState(() => _searchQuery = v),
                  ),
                ),

                // ── List / empty state ────────────────────────────
                if (deals.isEmpty)
                  Expanded(
                    child: EmptyStateWidget(
                      icon: Icons.search_off,
                      title: _searchQuery.isEmpty
                          ? 'No Interests Yet'
                          : 'No Results Found',
                      subtitle: _searchQuery.isEmpty
                          ? 'Tap "I\'m Interested" on any deal to save it here'
                          : 'Try a different search term',
                      actionLabel:
                      _searchQuery.isEmpty ? null : 'Clear Search',
                      onAction: _searchQuery.isEmpty
                          ? null
                          : () => setState(() => _searchQuery = ''),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: deals.length,
                      itemBuilder: (_, i) => DealCard(
                        deal: deals[i],
                        showRemove: true,
                      ),
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
}