import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundPlayerPage extends StatefulWidget {
  const SoundPlayerPage({super.key});

  @override
  _SoundPlayerPageState createState() => _SoundPlayerPageState();
}

class _SoundPlayerPageState extends State<SoundPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _selectedFile;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playSound(String fileName) async {
    try {
      await _audioPlayer.setAsset('assets/$fileName.mp3');
      await _audioPlayer.play();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de la lecture du son : $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lecteur de sons : Progression & Régression")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(
              height: 40,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Nom : Progression',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
                readOnly: true,
                onTap: () {
                  setState(() {
                    _selectedFile = "progression";
                  });
                  _playSound("progression");
                },
              ),
            ),
            const SizedBox(height: 16),
            // Input pour le son "régression"
            SizedBox(
              height: 40,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Nom : Régression',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                ),
                readOnly: true,
                onTap: () {
                  setState(() {
                    _selectedFile = "regression";
                  });
                  _playSound("regression");
                },
              ),
            ),
            const SizedBox(height: 16),

            if (_selectedFile != null)
              Text(
                "Fichier sélectionné : $_selectedFile.mp3",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
