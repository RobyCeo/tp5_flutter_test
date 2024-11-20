import 'package:flutter/material.dart';
import '../TrainingPlanStorage.dart';

class TrainingPlanPage extends StatefulWidget {
  const TrainingPlanPage({super.key});

  @override
  _TrainingPlanPageState createState() => _TrainingPlanPageState();
}

class _TrainingPlanPageState extends State<TrainingPlanPage> {
  final TrainingPlanStorage _storage = TrainingPlanStorage();
  List<Map<String, dynamic>> _trainingPlans = [];

  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _muscleController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTrainingPlans();
  }

  Future<void> _loadTrainingPlans() async {
    final plans = await _storage.loadTrainingPlans();
    setState(() {
      _trainingPlans = plans;
    });
  }

  Future<void> _addTrainingPlan() async {
    final exercise = _exerciseController.text.trim();
    final muscle = _muscleController.text.trim();
    final reps = int.tryParse(_repsController.text) ?? 0;
    final description = _descriptionController.text.trim();

    if (exercise.isNotEmpty && muscle.isNotEmpty && reps > 0 && description.isNotEmpty) {
      final plan = {
        'exerciseName': exercise,
        'muscleGroup': muscle,
        'reps': reps,
        'description': description,
      };

      setState(() {
        _trainingPlans.add(plan);
      });


      await _storage.saveTrainingPlans(_trainingPlans);


      await _storage.saveExerciseHistory(plan);


      _exerciseController.clear();
      _muscleController.clear();
      _repsController.clear();
      _descriptionController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs correctement')),
      );
    }
  }


  Future<void> _deleteTrainingPlan(int index) async {
    setState(() {
      _trainingPlans.removeAt(index);
    });
    await _storage.saveTrainingPlans(_trainingPlans);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Plan d'Entraînement")),
      body: Column(
        children: [

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _exerciseController,
                  decoration: const InputDecoration(labelText: 'Nom de l\'exercice'),
                ),
                TextField(
                  controller: _muscleController,
                  decoration: const InputDecoration(labelText: 'Groupe musculaire'),
                ),
                TextField(
                  controller: _repsController,
                  decoration: const InputDecoration(labelText: 'Nombre de répétitions'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _addTrainingPlan,
                  child: const Text("Ajouter l'exercice"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),


          Expanded(
            child: ListView.builder(
              itemCount: _trainingPlans.length,
              itemBuilder: (context, index) {
                final plan = _trainingPlans[index];
                return ListTile(
                  title: Text(plan['exerciseName']),
                  subtitle: Text(
                    '${plan['muscleGroup']} - ${plan['reps']} reps\n${plan['description']}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteTrainingPlan(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
