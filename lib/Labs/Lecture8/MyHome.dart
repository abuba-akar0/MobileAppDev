//Animate the Hello World text
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

  @override
  void initState() {
    super.initState();
    timeDilation = 1.0; // Slow down animations for better visibility
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hello World Animation'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: const Text(
            'Hello, World!',
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}