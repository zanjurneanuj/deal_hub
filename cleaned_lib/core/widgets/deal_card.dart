import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/deal_model.dart';
import '../../core/constants/app_colors.dart';
import '../../features/interests/bloc/interest_bloc.dart';
import '../../features/interests/bloc/interest_event.dart';
class DealCard extends StatelessWidget {
  final Deal deal;
  final bool showRemove; 
  final VoidCallback? onTap;
  const DealCard({
    Key? key,
    required this.deal,
    this.showRemove = false,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.cardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    deal.companyName,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildStatusBadge(deal.status),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "${deal.industry}  ${deal.location}",
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoTile(
                  "Investment",
                  "${deal.investmentRequired.toStringAsFixed(0)}",
                ),
                _infoTile(
                  "ROI",
                  "${deal.expectedROI}%",
                  valueColor: AppColors.accent,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildRiskBadge(deal.riskLevel),
                showRemove
                    ? TextButton(
                  onPressed: () {
                    context
                        .read<InterestBloc>()
                        .add(RemoveInterest(deal.id));
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.error,
                  ),
                  child: const Text("Remove"),
                )
                    : ElevatedButton(
                  onPressed: () {
                    context
                        .read<InterestBloc>()
                        .add(AddInterest(deal.id));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Added to Interests"),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text("Interested"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildStatusBadge(String status) {
    final isOpen = status == "Open";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isOpen ? AppColors.openBg : AppColors.closedBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: isOpen ? AppColors.open : AppColors.closed,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  Widget _buildRiskBadge(String risk) {
    Color color;
    Color bg;
    switch (risk) {
      case "High":
        color = AppColors.highRisk;
        bg = AppColors.highRiskBg;
        break;
      case "Medium":
        color = AppColors.mediumRisk;
        bg = AppColors.mediumRiskBg;
        break;
      default:
        color = AppColors.lowRisk;
        bg = AppColors.lowRiskBg;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        risk,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  Widget _infoTile(String label, String value, {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textHint,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}