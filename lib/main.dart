import 'package:flutter/material.dart';
import 'pages/more_page.dart';
import 'pages/bill_board_page.dart';
import 'pages/cleaning_supply_page.dart';
import 'pages/chores_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Split the Bill'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> _bottomNavigation = [
    CleaningSuppliesPage(),
    BillBoardPage(),
    ChoresPage(),
    MorePage()
  ];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: _bottomNavigation.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _bottomNavigation,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
            _tabController.animateTo(_currentIndex);
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              title: Text("Supplies"), icon: Icon(Icons.book)),
          BottomNavigationBarItem(
              title: Text("Billboard"), icon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(
              title: Text("Chores"), icon: Icon(Icons.filter_frames)),
          BottomNavigationBarItem(title: Text("More"), icon: Icon(Icons.menu)),
        ],
      ),
    );
  }
}
