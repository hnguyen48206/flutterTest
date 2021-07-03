import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:testnewproject/introPage/introUI.dart';
import 'splashPage/splashUI.dart';
import 'providers/globalHeroProvider.dart' as globalHero;

void main() => runApp(MyApp());
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
Widget homeScreen;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    if (!globalHero.isLoggedIn)
      homeScreen = SplashUI();
    else
      homeScreen = TestWidget();

    return MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (context) => homeScreen,
          'favoriteItemList': (context) => FavoriteWiget(),
          'intro': (context) => IntroUI()
        },
        onUnknownRoute: (RouteSettings setting) {
          String unknownRoute = setting.name;
          return new MaterialPageRoute(builder: (context) => NotFoundPage());
        },
        theme: ThemeData(
          // Add the 3 lines from here...
          primaryColor: Colors.teal,
        ),
        title: 'Test Project');
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
  // a List to store all the generated word pairs
  final _suggestions = <WordPair>[];

  // a Set to save favorites pairs chosen by a user.
  final _saved = <WordPair>{};

  final _biggerFont = const TextStyle(fontSize: 18);

  final _TestWidgetState testWidgetState = _TestWidgetState();

  @override
  _TestWidgetState createState() => testWidgetState;
}

class _TestWidgetState extends State<TestWidget> {
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
                Navigator.pushNamed(context, 'favoriteItemList',
                    arguments: DataToPassFromTestWidgetToFavoriteWidget(
                        widget._saved));
              }),
          IconButton(
              icon: Icon(Icons.add_chart),
              onPressed: () {
                Navigator.pushNamed(context, 'intro');
              }),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          final tiles = widget._saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: widget._biggerFont,
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
        }, // ...to here.
      ),
    );
  }

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
          if (index >= widget._suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            widget._suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(widget._suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    //check if a pair of words has already been saved.
    final alreadySaved = widget._saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: widget._biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            widget._saved.remove(pair);
            print('rm from favorite list');
            print(widget._saved);
          } else {
            widget._saved.add(pair);
            print('add to favorite list');
            print(widget._saved);
          }
        });
      },
    );
  }
}

class DataToPassFromTestWidgetToFavoriteWidget {
  var _saved = <WordPair>{};

  DataToPassFromTestWidgetToFavoriteWidget(this._saved);
}

class FavoriteWiget extends StatefulWidget {
  @override
  _FavoriteWigetState createState() => _FavoriteWigetState();
}

class _FavoriteWigetState extends State<FavoriteWiget> {
  bool shouldPop = true;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as DataToPassFromTestWidgetToFavoriteWidget;

    final tiles = args._saved.map(
      (WordPair pair) {
        return ListTile(
          title: Text(pair.asPascalCase),
          onTap: () {
            setState(() {
              args._saved.remove(pair);
              print(args._saved);
            });
          },
        );
      },
    );
    final divided = tiles.isNotEmpty
        ? ListTile.divideTiles(context: context, tiles: tiles).toList()
        : <ListTile>[];

    return WillPopScope(
        onWillPop: () async {
          print('about to pop back');
          // return shouldPop;
          Navigator.pop(context, false);
          return shouldPop;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Saved Suggestions'),
          ),
          body: ListView(children: divided),
        ));
  }
}
