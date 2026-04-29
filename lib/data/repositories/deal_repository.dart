import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/deal_model.dart';

class DealRepository {
  Future<List<Deal>> getDeals() async {
    final String response =
    await rootBundle.loadString('lib/core/utils/Deals.json');

    return Deal.listFromJson(response);
  }
}