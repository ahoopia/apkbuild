import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube Clone',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SubscriptionPage(),
    NewContentPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Clone'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Keep all items visible
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, size: 40), // Larger size for the new content icon
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue, // Change color for selected item
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> _imageUrls = List.generate(
    20,
    (index) => 'https://via.placeholder.com/300', // Replace with actual image URL
  );

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two columns
        mainAxisSpacing: 4.0, // Spacing between rows
        crossAxisSpacing: 4.0, // Spacing between columns
        childAspectRatio: 0.75, // Aspect ratio of the grid tiles
      ),
      itemCount: _imageUrls.length + 1, // Add one for loading indicator
      itemBuilder: (BuildContext context, int index) {
        if (index < _imageUrls.length) {
          return index >= _imageUrls.length - 1 && _isLoading
              ? Center(child: CircularProgressIndicator())
              : _buildGridTile(index);
        } else {
          return Container(); // Placeholder for loading indicator
        }
      },
    );
  }

  Widget _buildGridTile(int index) {
    return GridTile(
      child: Image.network(
        _imageUrls[index], // Use actual image URL
        fit: BoxFit.cover,
      ),
      footer: Container(
        color: Colors.white.withOpacity(0.7),
        child: ListTile(
          leading: Icon(Icons.video_library),
          title: Text('Video $index'),
        ),
      ),
    );
  }

  // Method to load more images
  void _loadMoreImages() {
    // Simulate loading delay
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
        // Add more images to the list
        _imageUrls.addAll(List.generate(
          20,
          (index) => 'https://via.placeholder.com/300', // Replace with actual image URL
        ));
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Listen for scroll events
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Reached the bottom of the list
        setState(() {
          _isLoading = true;
        });
        _loadMoreImages();
      }
    });
  }
}

class SubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20,
          (index) => ListTile(
            leading: Icon(Icons.subscriptions),
            title: Text('Subscription $index'),
          ),
        ),
      ),
    );
  }
}

class NewContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20,
          (index) => ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('New Content $index'),
          ),
        ),
      ),
    );
  }
}

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20,
          (index) => ListTile(
            leading: Icon(Icons.history),
            title: Text('History $index'),
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
          20,
          (index) => ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile $index'),
          ),
        ),
      ),
    );
  }
}
