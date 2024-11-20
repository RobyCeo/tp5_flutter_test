import 'package:flutter/material.dart';
import '../TrainingPlanStorage.dart';

class ExerciseHistoryPage extends StatefulWidget {
  const ExerciseHistoryPage({Key? key}) : super(key: key);

  @override
  _ExerciseHistoryPageState createState() => _ExerciseHistoryPageState();
}

class _ExerciseHistoryPageState extends State<ExerciseHistoryPage> {
  final TrainingPlanStorage _storage = TrainingPlanStorage();
  List<Map<String, dynamic>> _exerciseHistory = [];

  @override
  void initState() {
    super.initState();
    _loadExerciseHistory();
  }

  Future<void> _loadExerciseHistory() async {
    final history = await _storage.loadExerciseHistory();
    setState(() {
      _exerciseHistory = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historique des Exercices")),
      body: _exerciseHistory.isNotEmpty
          ? ListView.builder(
        itemCount: _exerciseHistory.length,
        itemBuilder: (context, index) {
          final exercise = _exerciseHistory[index];
          return ListTile(
            title: Text(exercise['exerciseName']),
            subtitle: Text(
              '${exercise['muscleGroup']} - ${exercise['reps']} reps\n${exercise['description']}',
            ),
          );
        },
      )
          : const Center(
        child: Text("Aucun exercice dans l'historique"),
      ),
    );
  }
}
