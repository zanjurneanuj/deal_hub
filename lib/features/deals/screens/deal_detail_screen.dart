import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/deal_model.dart';

class DealDetailScreen extends StatelessWidget {
  final Deal deal;

  const DealDetailScreen({
    Key? key,
    required this.deal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          deal.companyName,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            ///  OVERVIEW CARD
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Company Overview"),
                  const SizedBox(height: 8),
                  Text(
                    deal.companyOverview,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ///  FINANCIAL CARD
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Financial Highlights"),
                  const SizedBox(height: 12),

                  _infoRow("Investment",
                      "₹${deal.investmentRequired.toStringAsFixed(0)}"),
                  _infoRow("Expected ROI", "${deal.expectedROI}%"),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Risk"),
                      _riskBadge(deal.riskLevel),
                    ],
                  ),

                  _infoRow("Location", deal.location),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ///  ROI GRAPH CARD
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("ROI Projection"),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 160,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: deal.roiProjection.map((e) {
                        return Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "${e.roi}%",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),

                              Container(
                                height: e.roi * 2,
                                width: 12,
                                decoration: BoxDecoration(
                                  gradient: AppColors.accentGradient,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),

                              const SizedBox(height: 4),
                              Text(
                                "Y${e.year}",
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textHint,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            ///  RISK EXPLANATION
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _title("Risk Explanation"),
                  const SizedBox(height: 8),
                  Text(
                    deal.riskExplanation,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///  REUSABLE CARD
  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  ///  SECTION TITLE
  Widget _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  ///  INFO ROW
  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  ///  RISK BADGE
  Widget _riskBadge(String risk) {
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
        ),
      ),
    );
  }
}