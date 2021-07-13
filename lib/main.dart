import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

// Note: this code is copied from a Google codelab
// (https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1#0)

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18); // option for larger font

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested word pairing,
        // and places each suggestion into a ListTile row. For even rows, the
        // function adds a ListTile row for the word pairing. For odd rows, the
        // function adds a Divider widget to visually separate the entries. Note
        // that the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            // Add 1 pixel high divider widget before each row in ListView.
            return Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an integer result.
          // This calculates the actual number of word pairings in the ListView,
          // minus the divider widgets.
          final int index = i ~/ 2;
          if (index >= _suggestions.length) { // end of list
            // Generate 10 more suggestions
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
