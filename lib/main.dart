import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => TestWidget(),
        '/favoriteItemList': (BuildContext context) =>
            _TestWidgetState().pushSaved()
      },
      onUnknownRoute: (RouteSettings setting) {
        String unknownRoute = setting.name;
        return new MaterialPageRoute(builder: (context) => NotFoundPage());
      },
      theme: ThemeData(
        // Add the 3 lines from here...
        primaryColor: Colors.teal,
      ),
      title: 'Test Project',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Project'),
        ),
        body: Center(
          child: TestWidget(),
        ),
      ),
    );
  }
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          body: Center(
        child: Text('Not found page'),
      )),
    );
  }
}

class TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  // a List to store all the generated word pairs
  final _suggestions = <WordPair>[];

  // a Set to save favorites pairs chosen by a user.
  final _saved = <WordPair>{};

  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  Widget build(BuildContext context) {
    //return single value
    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);

    //return a list instead
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [
          IconButton(
              icon: Icon(Icons.navigate_next),
              onPressed: () {
                Navigator.pushNamed(context, 'favoriteItemList');
              }),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget pushSaved() {
    final tiles = _saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <ListTile>[];

    return Scaffold(
      appBar: AppBar(
        title: Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
  // void _pushSaved() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       builder: (BuildContext context) {
  //         final tiles = _saved.map(
  //           (WordPair pair) {
  //             return ListTile(
  //               title: Text(
  //                 pair.asPascalCase,
  //                 style: _biggerFont,
  //               ),
  //             );
  //           },
  //         );
  //         final divided = tiles.isNotEmpty
  //             ? ListTile.divideTiles(context: context, tiles: tiles).toList()
  //             : <ListTile>[];

  //         return Scaffold(
  //           appBar: AppBar(
  //             title: Text('Saved Suggestions'),
  //           ),
  //           body: ListView(children: divided),
  //         );
  //       }, // ...to here.
  //     ),
  //   );
  // }

  // ignore: unused_element
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.

        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return Divider();
          }

          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    //check if a pair of words has already been saved.
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
            print('rm from favorite list');
          } else {
            _saved.add(pair);
            print('add to favorite list');
          }
        });
      },
    );
  }
}
