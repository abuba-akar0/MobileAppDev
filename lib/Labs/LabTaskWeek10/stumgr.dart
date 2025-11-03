import 'package:flutter/material.dart';

void main() {
  runApp(StudentManagerApp());
}

class StudentManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Manager',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: StudentHomePage(),
    );
  }
}

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  List<Map<String, String>> students = [
    {"name": "Ali Raza", "id": "ST-001", "dept": "Computer Science"},
    {"name": "Hassan Khan", "id": "ST-002", "dept": "Software Eng"},
    {"name": "Ayesha Malik", "id": "ST-003", "dept": "IT"},
    {"name": "Sara Ahmed", "id": "ST-004", "dept": "Cyber Security"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverAppBar
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Student Manager'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/students.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              ),
            ),
          ),

          // Safe Area for Content
          SliverSafeArea(
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Student List",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // List of Students (Dismissible + Card + ListTile)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: students.length,
                  itemBuilder: (context, index) {
                    final student = students[index];
                    return Dismissible(
                      key: Key(student["id"].toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (direction) {
                        setState(() {
                          students.removeAt(index);
                        });
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        elevation: 3,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade200,
                            child: Text(student["name"]![0]),
                          ),
                          title: Text(student["name"]!),
                          subtitle: Text(
                              "${student["id"]} • ${student["dept"]}"),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Grid Section
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Performance Overview",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // GridView.count Example
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: const EdgeInsets.all(8),
                  children: [
                    buildGridCard(Icons.people, "Total Students", "4"),
                    buildGridCard(Icons.school, "Active Courses", "12"),
                    buildGridCard(Icons.grade, "Avg GPA", "3.5"),
                    buildGridCard(Icons.celebration, "Graduating", "2"),
                  ],
                ),

                const SizedBox(height: 20),

                // GridView.extent Example
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Top Students",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                GridView.extent(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  padding: const EdgeInsets.all(8),
                  children: [
                    buildTopStudent("Ali Raza"),
                    buildTopStudent("Ayesha Malik"),
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for Grid Cards
  Widget buildGridCard(IconData icon, String title, String value) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  // Helper widget for Top Students (Stack Example)
  Widget buildTopStudent(String name) {
    return Stack(
      children: [
        Card(
          color: Colors.blue.shade50,
          elevation: 3,
          child: Center(
            child: Text(
              name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "⭐ Top",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ],
    );
  }
}
