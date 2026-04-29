import 'dart:convert';
import 'package:equatable/equatable.dart';
class RoiData extends Equatable {
  final int year;
  final double roi;
  const RoiData({
    required this.year,
    required this.roi,
  });
  factory RoiData.fromJson(Map<String, dynamic> json) {
    return RoiData(
      year: json['year'],
      roi: (json['roi'] as num).toDouble(),
    );
  }
  @override
  List<Object?> get props => [year, roi];
}
class Deal extends Equatable {
  final String id;
  final String companyName;
  final String industry;
  final double investmentRequired;
  final double expectedROI;
  final String riskLevel;
  final String status;
  final String companyOverview;
  final String financialHighlights; 
  final String riskExplanation;
  final String founded;
  final int employees;
  final String location;
  final List<RoiData> roiProjection;
  const Deal({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.investmentRequired,
    required this.expectedROI,
    required this.riskLevel,
    required this.status,
    required this.companyOverview,
    required this.financialHighlights,
    required this.riskExplanation,
    required this.founded,
    required this.employees,
    required this.location,
    required this.roiProjection,
  });
  bool get isOpen => status == 'Open';
  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      companyName: json['companyName'],
      industry: json['industry'],
      investmentRequired: (json['investmentRequired'] as num).toDouble(),
      expectedROI: (json['expectedROI'] as num).toDouble(),
      riskLevel: json['riskLevel'],
      status: json['status'],
      companyOverview: json['companyOverview'],
      financialHighlights: json['financialHighlights'],
      riskExplanation: json['riskExplanation'],
      founded: json['founded'],
      employees: json['employees'],
      location: json['location'],
      roiProjection: (json['roiProjection'] as List)
          .map((e) => RoiData.fromJson(e))
          .toList(),
    );
  }
  static List<Deal> listFromJson(String source) {
    final data = json.decode(source) as List;
    return data.map((e) => Deal.fromJson(e)).toList();
  }
  @override
  List<Object?> get props => [id];
}