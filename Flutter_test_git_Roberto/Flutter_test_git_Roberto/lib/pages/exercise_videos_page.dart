import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ExerciseVideosPage extends StatefulWidget {
  const ExerciseVideosPage({super.key});

  @override
  State<ExerciseVideosPage> createState() => _ExerciseVideosPageState();
}

class _ExerciseVideosPageState extends State<ExerciseVideosPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/videos/video_roberto.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vidéo d'Exercice")),
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : const CircularProgressIndicator(),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.black.withOpacity(0.7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop, color: Colors.white, size: 40),
                    onPressed: () {
                      setState(() {
                        _controller.pause();
                        _controller.seekTo(Duration.zero);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
