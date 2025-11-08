import 'package:flutter/material.dart';

void main() => runApp(QuickLearnApp());

class QuickLearnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickLearn Cards',
      theme: ThemeData(primarySwatch: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: QuickLearnHome(),
    );
  }
}

class QuickLearnHome extends StatefulWidget {
  @override
  State<QuickLearnHome> createState() => _QuickLearnHomeState();
}

class _QuickLearnHomeState extends State<QuickLearnHome> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Map<String, dynamic>> cards = [
    {'q': 'Flutter is developed by?', 'a': 'Google', 'show': false, 'learned': false},
    {'q': 'What is Dart?', 'a': 'A programming language for Flutter.', 'show': false, 'learned': false},
    {'q': 'What is Widget?', 'a': 'A basic building block of UI.', 'show': false, 'learned': false},
    {'q': 'Hot Reload does?', 'a': 'Applies changes instantly.', 'show': false, 'learned': false},
    {'q': 'setState() use?', 'a': 'Updates the widget tree.', 'show': false, 'learned': false},
    {'q': 'Scaffold provides?', 'a': 'Material Design layout structure.', 'show': false, 'learned': false},
    {'q': 'What is ListView?', 'a': 'Scrollable list of widgets.', 'show': false, 'learned': false},
    {'q': 'What is Container?', 'a': 'A box to style and position child widgets.', 'show': false, 'learned': false},
  ];

  int learned = 0;

  Future<void> _refreshCards() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      cards = [
        {'q': 'MaterialApp used for?', 'a': 'Provides app structure.', 'show': false, 'learned': false},
        {'q': 'Column arranges?', 'a': 'Widgets vertically.', 'show': false, 'learned': false},
        {'q': 'Row arranges?', 'a': 'Widgets horizontally.', 'show': false, 'learned': false},
        {'q': 'StatefulWidget?', 'a': 'Widget with changeable state.', 'show': false, 'learned': false},
        {'q': 'StatelessWidget?', 'a': 'Widget without changing state.', 'show': false, 'learned': false},
        {'q': 'Navigator used for?', 'a': 'Screen navigation.', 'show': false, 'learned': false},
        {'q': 'BuildContext?', 'a': 'Stores widget location in tree.', 'show': false, 'learned': false},
      ];
      learned = 0;
    });
  }

  void _addCard() {
    final newCard = {
      'q': 'New Question ${cards.length + 1}',
      'a': 'This is its answer.',
      'show': false,
      'learned': false
    };
    cards.insert(0, newCard);
    _listKey.currentState?.insertItem(0);
    setState(() {});
  }

  void _markLearned(int index) {
    if (index < 0 || index >= cards.length) return;
    final removed = cards[index];
    cards.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildCard(removed, index),
      ),
      duration: const Duration(milliseconds: 300),
    );
    setState(() => learned++);
  }

  void _tapToReveal(int index) {
    setState(() {
      cards[index]['show'] = !cards[index]['show'];
      if (cards[index]['show'] == true && cards[index]['learned'] == false) {
        // count as learned once
        cards[index]['learned'] = true;
        learned++;
      }
    });
  }

  Widget _buildCard(Map<String, dynamic> card, int index) {
    final isShown = card['show'];
    return GestureDetector(
      onTap: () => _tapToReveal(index),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: isShown ? Colors.indigo.shade100 : Colors.white,
        elevation: 3,
        child: Container(
          height: 120, // square shape
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              isShown ? card['a'] : card['q'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int total = cards.length + learned;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard,
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshCards,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 120,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Progress: $learned of $total learned'),
                background: Container(color: Colors.indigo),
              ),
            ),
            SliverToBoxAdapter(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: cards.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index, animation) {
                  final card = cards[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (_) => _markLearned(index),
                      background: Container(
                        color: Colors.green,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.check, color: Colors.white),
                      ),
                      child: _buildCard(card, index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
