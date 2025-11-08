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

  List<Map<String, String>> cards = [
    {'q': 'Flutter is developed by?', 'a': 'Google', 'show': 'false'},
    {'q': 'What is Dart?', 'a': 'A programming language for Flutter.', 'show': 'false'},
    {'q': 'What is Widget?', 'a': 'A basic building block of UI.', 'show': 'false'},
    {'q': 'Hot Reload does?', 'a': 'Applies changes instantly.', 'show': 'false'},
    {'q': 'setState() use?', 'a': 'Updates the widget tree.', 'show': 'false'},
    {'q': 'Scaffold provides?', 'a': 'Material Design layout structure.', 'show': 'false'},
    {'q': 'What is ListView?', 'a': 'Scrollable list of widgets.', 'show': 'false'},
    {'q': 'What is Container?', 'a': 'A box to style and position child widgets.', 'show': 'false'},
  ];

  int learned = 0;

  Future<void> _refreshCards() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      cards = [
        {'q': 'MaterialApp used for?', 'a': 'Provides app structure.', 'show': 'false'},
        {'q': 'Column arranges?', 'a': 'Widgets vertically.', 'show': 'false'},
        {'q': 'Row arranges?', 'a': 'Widgets horizontally.', 'show': 'false'},
        {'q': 'StatefulWidget?', 'a': 'Widget with changeable state.', 'show': 'false'},
        {'q': 'StatelessWidget?', 'a': 'Widget without changing state.', 'show': 'false'},
        {'q': 'Navigator used for?', 'a': 'Screen navigation.', 'show': 'false'},
        {'q': 'BuildContext?', 'a': 'Stores widget location in tree.', 'show': 'false'},
      ];
      learned = 0;
    });
  }

  void _addCard() {
    final newCard = {
      'q': 'New Question ${cards.length + 1}',
      'a': 'This is its answer.',
      'show': 'false'
    };
    cards.insert(0, newCard);
    _listKey.currentState?.insertItem(0);
  }

  void _markLearned(int index) {
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

  Widget _buildCard(Map<String, String> card, int index) {
    final isShown = card['show'] == 'true';
    return GestureDetector(
      onTap: () {
        setState(() {
          card['show'] = isShown ? 'false' : 'true';
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: isShown ? Colors.indigo.shade100 : Colors.white,
        elevation: 3,
        child: Container(
          height: 120, // makes it look square-like
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              isShown ? card['a']! : card['q']!,
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
                title: Text('Learned: $learned / ${cards.length + learned}'),
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
