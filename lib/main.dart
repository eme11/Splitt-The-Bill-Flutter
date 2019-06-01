import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:scoped_model/scoped_model.dart';

import 'scoped_models/main_model.dart';

import 'pages/more_page.dart';
import 'pages/bill_board_page.dart';
import 'pages/cleaning_supply_page.dart';
import 'pages/chores_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/sign_up_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    return ScopedModel<MainModel>(
      model: model,
      child: new DynamicTheme(
          defaultBrightness: Brightness.light,
          data: (brightness) => new ThemeData(
                primarySwatch: Colors.red,
                brightness: brightness,
              ),
          themedWidgetBuilder: (context, theme) {
            return new MaterialApp(
              theme: theme,
              routes: {
                '/': (BuildContext context) => SignInPage(),
                '/application': (BuildContext context) =>
                    new MyHomePage(model, title: 'Split the Bill'),
                '/register': (BuildContext context) => SignUpPage()
              },
            );
          }),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MainModel model;
  MyHomePage(this.model, {Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  List<Widget> _bottomNavigation = [];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _bottomNavigation = [
      CleaningSuppliesPage(),
      BillBoardPage(),
      ChoresPage(),
      MorePage()
    ];
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
