import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/emergency_models.dart';

class EmergencyService {
  static final EmergencyService _instance = EmergencyService._internal();
  factory EmergencyService() => _instance;
  EmergencyService._internal();

  List<EmergencyCategory> _categories = [];
  bool _isLoaded = false;

  Future<void> loadGuides() async {
    if (_isLoaded) return;
    try {
      final jsonString = await rootBundle.loadString('assets/data/emergency_guides.json');
      final data = json.decode(jsonString);
      var list = data['categories'] as List? ?? [];
      _categories = list.map((c) => EmergencyCategory.fromJson(c)).toList();
      _isLoaded = true;
    } catch (e) {
      // In production, log error or fallback to a hardcoded minimal dataset.
      _categories = [];
      rethrow;
    }
  }

  List<EmergencyCategory> get categories => _categories;

  EmergencyCategory? getCategoryById(String id) {
    try {
      return _categories.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  List<EmergencyCategory> searchCategories(String query, String languageCode) {
    if (query.isEmpty) return _categories;
    final lowercaseQuery = query.toLowerCase();
    return _categories.where((c) {
      final title = c.title.value(languageCode).toLowerCase();
      final desc = c.description.value(languageCode).toLowerCase();
      return title.contains(lowercaseQuery) || desc.contains(lowercaseQuery);
    }).toList();
  }
}
