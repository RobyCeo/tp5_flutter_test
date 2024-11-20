import 'package:flutter/material.dart';
import 'exercise_list_page.dart';
import 'reps_validation_page.dart';
import 'training_plan_page.dart';
import 'exercise_videos_page.dart';
import '../ExerciseHistoryPage.dart';
import '../SavePdfPage.dart';
import '../SoundPlayerPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application d'entrainement"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Liste des Exercices'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExerciseListPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Validation des Répétitions'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RepsValidationPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Plan d\'Entraînement'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TrainingPlanPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Vidéos d\'Exercices'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExerciseVideosPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Historique des Exercices'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExerciseHistoryPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Sauvegarder PDF'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SavePdfPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Lecteur de Son'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SoundPlayerPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
        child: AnimatedText(),
      ),
    );
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({super.key});

  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);


    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Text(
          "ROBYKOUT",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 70,
            fontWeight: FontWeight.bold,
            color: _colorAnimation.value,
          ),
        );
      },
    );
  }
}
