import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App', // App title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Home screen of the app is BiddingPage
      home: const CounterPage(title: 'Counter Page'),
      debugShowCheckedModeBanner: false, // Removes debug banner
    );
  }
}

// StatefulWidget because we need to update bid value dynamically
class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title; // Title text passed to AppBar

  @override
  State<CounterPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<CounterPage> {
  int counter = 0; // initial counter value (starts at 0)

  // Function to increase counter value
  void _increasecount() {
    setState(() {
      counter += 10; // Each button press increases counter by 10
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title), // Display page title in AppBar
      ),
      body: Center(
        // Layout is vertically centered
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Instruction text
            const Text(
              'Current Counter Value:',
              style: TextStyle(fontSize: 20),
            ),
            // Display current value
            Text(
              '$counter',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20), // Spacing between text and button

            // Button to increase counter
            ElevatedButton(
              onPressed: _increasecount, // Calls function when pressed
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Add 10",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
