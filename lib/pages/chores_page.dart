import 'package:flutter/material.dart';

import '../pop_up_widows/chores_form.dart';

class ChoresPage extends StatefulWidget{
  List<Widget> _choresCards = [];
  @override
  State<StatefulWidget> createState() {
    return _ChoresPageState();
  }

}

class _ChoresPageState extends State<ChoresPage>{

  Widget _buildBody(){

  }

  void addChoresCard(){

  }

  void deleteChoresCard(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => ChoresForm(addChoresCard));
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }

}