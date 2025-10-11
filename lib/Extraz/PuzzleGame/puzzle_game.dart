import 'package:flutter/material.dart';
import 'dart:math';

class PuzzleGame extends StatefulWidget {
  const PuzzleGame({Key? key}) : super(key: key);

  @override
  State<PuzzleGame> createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  static const int size = 3; // 3x3 puzzle
  late List<int> tiles;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    tiles = List.generate(size * size, (i) => i);
    do {
      tiles.shuffle(Random());
    } while (!_isSolvable(tiles));
    setState(() {});
  }

  bool _isSolvable(List<int> list) {
    int inv = 0;
    for (int i = 0; i < list.length; i++) {
      for (int j = i + 1; j < list.length; j++) {
        if (list[i] != 0 && list[j] != 0 && list[i] > list[j]) inv++;
      }
    }
    return inv % 2 == 0;
  }

  void _onTileTap(int index) {
    int empty = tiles.indexOf(0);
    int row = index ~/ size, col = index % size;
    int emptyRow = empty ~/ size, emptyCol = empty % size;
    if ((row == emptyRow && (col - emptyCol).abs() == 1) ||
        (col == emptyCol && (row - emptyRow).abs() == 1)) {
      setState(() {
        tiles[empty] = tiles[index];
        tiles[index] = 0;
      });
    }
  }

  bool get _isCompleted =>
      List.generate(size * size, (i) => i).join() == tiles.join();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _shuffle,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isCompleted)
              const Text(
                'Congratulations!',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
            SizedBox(
              width: 300,
              height: 300,
              child: GridView.builder(
                itemCount: size * size,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size,
                ),
                itemBuilder: (context, index) {
                  final value = tiles[index];
                  return GestureDetector(
                    onTap: value != 0 && !_isCompleted
                        ? () => _onTileTap(index)
                        : null,
                    child: Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: value == 0
                            ? Colors.grey[300]
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: value == 0
                            ? const SizedBox.shrink()
                            : Text(
                                '$value',
                                style: const TextStyle(
                                    fontSize: 32, color: Colors.white),
                              ),
                      ),
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

