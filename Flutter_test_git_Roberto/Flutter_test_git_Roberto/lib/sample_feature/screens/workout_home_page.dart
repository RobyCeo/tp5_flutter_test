import 'package:flutter/material.dart';
import '../../pages/training_plan_page.dart';

class WorkoutHomePage extends StatelessWidget {
  const WorkoutHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Tracker"),
      ),
      body: const WorkoutContent(),
    );
  }
}

class WorkoutContent extends StatefulWidget {
  const WorkoutContent({super.key});

  @override
  _WorkoutContentState createState() => _WorkoutContentState();
}

class _WorkoutContentState extends State<WorkoutContent> {
  final TextEditingController _repsController = TextEditingController();
  Map<String, List<int>> exerciseReps = {
    'Bench Press': [],
    'Squat': [],
    'Deadlift': []
  };
  String? selectedExercise;
  Color feedbackColor = Colors.black;

  void validateReps() {
    final int? enteredReps = int.tryParse(_repsController.text);
    if (enteredReps != null && selectedExercise != null) {
      setState(() {
        final previousReps = exerciseReps[selectedExercise]!.isEmpty
            ? null
            : exerciseReps[selectedExercise]!.last;

        // Mise à jour de la couleur en fonction de la progression
        if (previousReps == null) {
          feedbackColor = Colors.blue;
        } else if (enteredReps > previousReps) {
          feedbackColor = Colors.green;
        } else if (enteredReps < previousReps) {
          feedbackColor = Colors.red;
        } else {
          feedbackColor = Colors.black;
        }

        // Ajout des répétitions dans la liste pour l'exercice sélectionné
        exerciseReps[selectedExercise]!.add(enteredReps);
        _repsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Affichage de la liste des exercices
        Expanded(
          child: ListView.builder(
            itemCount: exerciseReps.keys.length,
            itemBuilder: (context, index) {
              final exerciseName = exerciseReps.keys.elementAt(index);
              return ListTile(
                title: Text(exerciseName),
                subtitle: Text("Muscle: ${exerciseName == 'Bench Press' ? 'Chest' : exerciseName == 'Squat' ? 'Legs' : 'Back'}"),
                onTap: () {
                  setState(() {
                    selectedExercise = exerciseName;
                  });
                },
              );
            },
          ),
        ),

        // Affichage de l'historique et du champ de saisie si un exercice est sélectionné
        if (selectedExercise != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selected Exercise: $selectedExercise",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                if (exerciseReps[selectedExercise]!.isNotEmpty)
                  Text(
                    "Previous Reps: ${exerciseReps[selectedExercise]!.join(', ')}",
                    style: const TextStyle(fontSize: 16),
                  ),
                const SizedBox(height: 10),
                TextField(
                  controller: _repsController,
                  decoration: InputDecoration(
                    labelText: 'Enter Repetitions',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: validateReps,
                  child: const Text("Validate Reps"),
                ),
                const SizedBox(height: 10),
                Text(
                  "Progress feedback",
                  style: TextStyle(color: feedbackColor),
                ),
              ],
            ),
          ),

        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TrainingPlanPage()),
            );
          },
          child: const Text("View Training Plan"),
        ),
      ],
    );
  }
}
