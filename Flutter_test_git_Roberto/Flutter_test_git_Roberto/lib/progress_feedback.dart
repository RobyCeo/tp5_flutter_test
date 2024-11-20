import 'package:flutter/material.dart';

class ProgressFeedback extends StatefulWidget {
  final bool isProgression;
  const ProgressFeedback({Key? key, required this.isProgression}) : super(key: key);

  @override
  _ProgressFeedbackState createState() => _ProgressFeedbackState();
}

class _ProgressFeedbackState extends State<ProgressFeedback> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();


    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  void didUpdateWidget(covariant ProgressFeedback oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isProgression != oldWidget.isProgression) {
      if (!_controller.isAnimating) {
        _controller.forward().then((_) => _controller.reverse());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Text(
        widget.isProgression ? "Progression" : "Régression",
        style: TextStyle(
          fontSize: widget.isProgression ? 24.0 : 20.0,
          color: widget.isProgression ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
