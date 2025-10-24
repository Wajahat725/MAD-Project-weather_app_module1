import 'package:flutter/material.dart';

class AnimatedCloud extends StatefulWidget {
  const AnimatedCloud({super.key});

  @override
  State<AnimatedCloud> createState() => _AnimatedCloudState();
}

class _AnimatedCloudState extends State<AnimatedCloud> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.2,
          duration: const Duration(seconds: 2),
          child: const Icon(Icons.cloud, size: 80, color: Colors.white),
        ),
        ElevatedButton(
          onPressed: () => setState(() => _visible = !_visible),
          child: Text(_visible ? "Hide Cloud ☁️" : "Show Cloud ☁️"),
        ),
      ],
    );
  }
}
