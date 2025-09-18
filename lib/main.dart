import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp()); // Entry point: runs the app
}

// Root widget of the app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bidding App', // App title
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Home screen of the app is BiddingPage
      home: const BiddingPage(title: 'Bidding Page'),
      debugShowCheckedModeBanner: false, // Removes debug banner
    );
  }
}

// StatefulWidget because we need to update bid value dynamically
class BiddingPage extends StatefulWidget {
  const BiddingPage({super.key, required this.title});

  final String title; // Title text passed to AppBar

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  int bid = 0; // initial bid amount (starts at 0)

  // Function to increase bid value
  void _increaseBid() {
    setState(() {
      bid += 50; // Each button press increases bid by $50
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
              'Current Maximum Bid:',
              style: TextStyle(fontSize: 20),
            ),
            // Display current bid value
            Text(
              '\$$bid', // Shows bid with $ sign
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 20), // Spacing between text and button

            // Button to increase bid
            ElevatedButton(
              onPressed: _increaseBid, // Calls function when pressed
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                "Increase Bid",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
