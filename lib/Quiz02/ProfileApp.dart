import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = TextEditingController();
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    // Check current screen orientation
    var orientation = MediaQuery.of(context).orientation == Orientation.portrait
        ? "Portrait"
        : "Landscape";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Screen"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Picture
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.teal,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),

              // RichText (Name + Email)
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Abubakar Ahmad\n",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "abubakar@example.com",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Row with Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Edit button clicked")),
                      );
                    },
                    child: const Text("Edit"),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Logout button clicked")),
                      );
                    },
                    child: const Text("Logout"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Description Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Hello! I'm Abubakar Ahmad, a Computer Science student passionate about technology and programming.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(height: 20),

              // TextField with validation
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: "Enter Username",
                  border: const OutlineInputBorder(),
                  errorText: _errorText,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _errorText = _controller.text.isEmpty
                        ? "Username cannot be empty!"
                        : null;
                  });
                },
                child: const Text("Validate"),
              ),
              const SizedBox(height: 30),

              // Orientation Display
              Text(
                "Current Orientation: $orientation",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
