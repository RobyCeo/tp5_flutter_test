import 'package:flutter/material.dart';

class RepsValidationPage extends StatefulWidget {
  const RepsValidationPage({super.key});

  @override
  _RepsValidationPageState createState() => _RepsValidationPageState();
}

class _RepsValidationPageState extends State<RepsValidationPage> with SingleTickerProviderStateMixin {
  final TextEditingController _repsController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  String? selectedExercise;
  Color feedbackColor = Colors.black;
  Map<String, List<int>> exerciseReps = {
    'Bench Press': [],
    'Squat': [],
    'Deadlift': []
  };

  @override
  void initState() {
    super.initState();


    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _repsController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void validateReps() {
    final int? enteredReps = int.tryParse(_repsController.text);
    if (enteredReps != null && selectedExercise != null) {
      setState(() {
        final previousReps = exerciseReps[selectedExercise]!.isEmpty
            ? null
            : exerciseReps[selectedExercise]!.last;

        if (previousReps == null) {
          feedbackColor = Colors.blue;
        } else if (enteredReps > previousReps) {
          feedbackColor = Colors.green;
          _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
          );
          _animationController.forward().then((_) => _animationController.reverse());
        } else if (enteredReps < previousReps) {

          feedbackColor = Colors.red;
          _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
          );
          _animationController.forward().then((_) => _animationController.reverse());
        } else {
          feedbackColor = Colors.black;
        }

        exerciseReps[selectedExercise]!.add(enteredReps);
        _repsController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Validation des Répétitions")),
      body: Column(
        children: [
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
          if (selectedExercise != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Exercise choisi: $selectedExercise",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  if (exerciseReps[selectedExercise]!.isNotEmpty)
                    Text(
                      "Répétitions antérieures: ${exerciseReps[selectedExercise]!.join(', ')}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _repsController,
                    decoration: InputDecoration(
                      labelText: 'Entrez vos répétitions',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: validateReps,
                    child: const Text("Validez vos répétitions"),
                  ),
                  const SizedBox(height: 10),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: Text(
                      "Retour sur la progression",
                      style: TextStyle(color: feedbackColor, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
