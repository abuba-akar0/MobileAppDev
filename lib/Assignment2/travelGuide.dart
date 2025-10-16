import 'package:flutter/material.dart';

void main() {
  runApp(TravelGuideApp());
}

// ---------------------------
// OOP Class for App Structure
// ---------------------------
class TravelGuideApp extends StatefulWidget {
  @override
  State<TravelGuideApp> createState() => _TravelGuideAppState();
}

class _TravelGuideAppState extends State<TravelGuideApp> {
  int _currentIndex = 0; // To switch screens

  // Basic screen objects
  final HomeScreen home = HomeScreen();
  final ListScreen list = ListScreen();
  final AboutScreen about = AboutScreen();

  // Getter for current screen (OOP)
  Widget get currentScreen {
    if (_currentIndex == 0) return home;
    if (_currentIndex == 1) return list;
    return about;
  }

  // Setter for index
  set changeScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Travel Guide")),
        body: SafeArea(child: currentScreen),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => changeScreen = index,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Places"),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ---------------------------
// Home Screen Class
// ---------------------------
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController destination = TextEditingController();
  bool showWelcome = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/travel.png"),
          const SizedBox(height: 10),
          AnimatedCrossFade(
            duration: const Duration(seconds: 1),
            firstChild: Container(
              padding: const EdgeInsets.all(15),
              color: Colors.teal[50],
              child: const Text(
                "Welcome to Travel Guide App! Explore and plan your dream destinations.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            secondChild: const SizedBox(),
            crossFadeState: showWelcome
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
          ),
          const SizedBox(height: 10),
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 20),
              children: [
                TextSpan(text: "Explore the "),
                TextSpan(
                  text: "World",
                  style:
                  TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: " with Us!"),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: destination,
              decoration: const InputDecoration(
                labelText: "Enter Destination",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Searching for ${destination.text.isEmpty ? "destination" : destination.text}..."),
              ));
            },
            child: const Text("Search"),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  showWelcome = !showWelcome;
                });
              },
              child: const Text("Toggle Welcome Message")),
        ],
      ),
    );
  }
}

// ---------------------------
// List Screen Class
// ---------------------------
class ListScreen extends StatelessWidget {
  final List<Map<String, String>> places = [
    {"name": "Paris", "desc": "City of love and lights."},
    {"name": "Rome", "desc": "Home of the Colosseum."},
    {"name": "Dubai", "desc": "Modern desert paradise."},
    {"name": "Tokyo", "desc": "Tech capital of the world."},
    {"name": "New York", "desc": "City that never sleeps."},
    {"name": "Sydney", "desc": "Opera House & beaches."},
    {"name": "Cairo", "desc": "Pyramids of Giza."},
    {"name": "Istanbul", "desc": "Where East meets West."},
    {"name": "London", "desc": "Big Ben and Thames River."},
    {"name": "Bangkok", "desc": "Temples and street food."},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: places
          .map((p) => ListTile(
        leading: const Icon(Icons.location_on, color: Colors.teal),
        title: Text(p["name"]!),
        subtitle: Text(p["desc"]!),
      ))
          .toList(),
    );
  }
}

// ---------------------------
// About Screen Class
// ---------------------------
class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Famous Attractions Around the World",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: const [
              ImageItem(name: "Eiffel Tower", image: "assets/images/paris.png"),
              ImageItem(name: "Colosseum", image: "assets/images/rome.png"),
              ImageItem(name: "Burj Khalifa", image: "assets/images/dubai.png"),
              ImageItem(name: "Statue of Liberty", image: "assets/images/ny.png"),
              ImageItem(name: "Sydney Opera", image: "assets/images/sydney.png"),
              ImageItem(name: "Tokyo Tower", image: "assets/images/tokyo.png"),
            ],
          ),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _opacity = _opacity == 1.0 ? 0.0 : 1.0;
            });
          },
          child: const Text("Fade Title"),
        ),
      ],
    );
  }
}

// ---------------------------
// Helper Widget Class
// ---------------------------
class ImageItem extends StatelessWidget {
  final String name;
  final String image;

  const ImageItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.teal),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
          ),
          Text(name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
        ],
      ),
    );
  }
}
