import 'package:flutter/material.dart';

class ExerciseListPage extends StatelessWidget {
  const ExerciseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exercises = [
      {'name': 'Bench Press', 'muscle': 'Chest', 'description': 'Exercise pour les muscles des pec.'},
      {'name': 'Squat', 'muscle': 'Legs', 'description': 'Exercise pour les jambes.'},
      {'name': 'Deadlift', 'muscle': 'Back', 'description': 'Exercise pour le dos.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Liste des Exercices")),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final exercise = exercises[index];
          return ListTile(
            title: Text(exercise['name']!),
            subtitle: Text('${exercise['muscle']} - ${exercise['description']}'),
          );
        },
      ),
    );
  }
}
