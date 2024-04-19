import 'package:flutter/material.dart';

void main() {
  runApp(SearchApp());
}

class SearchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Component',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> items = List.generate(100, (index) => 'Item $index');
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
      floatingActionButton: AlphabetScrollBar(
        onAlphabetSelected: (index) {
          _scrollToIndex(index);
        },
      ),
    );
  }

  void _scrollToIndex(int index) {
    double itemExtent = 50; // Adjust this value according to your item height
    _controller.animateTo(index * itemExtent,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}

class AlphabetScrollBar extends StatelessWidget {
  final Function(int) onAlphabetSelected;

  const AlphabetScrollBar({Key key, this.onAlphabetSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 26; i++)
            GestureDetector(
              onTap: () {
                if (onAlphabetSelected != null) {
                  onAlphabetSelected(i);
                }
              },
              child: Container(
                width: 30,
                height: 20,
                margin: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(
                  child: Text(String.fromCharCode('A'.codeUnitAt(0) + i)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
