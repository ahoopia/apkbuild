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
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.blue,
        ),
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
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
        title: Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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

class AlphabetScrollBar extends StatefulWidget {
  final void Function(int) onAlphabetSelected;

  const AlphabetScrollBar({Key? key, required this.onAlphabetSelected}) : super(key: key);

  @override
  _AlphabetScrollBarState createState() => _AlphabetScrollBarState();
}

class _AlphabetScrollBarState extends State<AlphabetScrollBar> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 26; i++)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = i;
                  });
                  widget.onAlphabetSelected(i);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    color: _selectedIndex == i ? Colors.blue.withOpacity(0.5) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      String.fromCharCode('A'.codeUnitAt(0) + i),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: _selectedIndex == i ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
