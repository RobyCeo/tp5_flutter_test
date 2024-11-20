import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TrainingPlanStorage {
  static const String _trainingPlansKey = 'trainingPlans';
  static const String _exerciseHistoryKey = 'exerciseHistory';

  Future<void> saveTrainingPlans(List<Map<String, dynamic>> trainingPlans) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedPlans = jsonEncode(trainingPlans);
    await prefs.setString(_trainingPlansKey, encodedPlans);
  }

  Future<List<Map<String, dynamic>>> loadTrainingPlans() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedPlans = prefs.getString(_trainingPlansKey);

    if (encodedPlans != null) {
      final List<dynamic> decodedPlans = jsonDecode(encodedPlans);
      return decodedPlans.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }

  Future<void> saveExerciseHistory(Map<String, dynamic> exercise) async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedHistory = prefs.getString(_exerciseHistoryKey);

    List<Map<String, dynamic>> history = [];
    if (encodedHistory != null) {
      final List<dynamic> decodedHistory = jsonDecode(encodedHistory);
      history = decodedHistory.cast<Map<String, dynamic>>();
    }

    history.add(exercise);
    final String updatedHistory = jsonEncode(history);
    await prefs.setString(_exerciseHistoryKey, updatedHistory);
  }

  Future<List<Map<String, dynamic>>> loadExerciseHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedHistory = prefs.getString(_exerciseHistoryKey);

    if (encodedHistory != null) {
      final List<dynamic> decodedHistory = jsonDecode(encodedHistory);
      return decodedHistory.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }
}
