import 'package:flutter/material.dart';

import '../pop_up_widows/cleaning_supplies_form.dart';

class CleaningSuppliesPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CleaningSuppliesPageState();
  }

}

class _CleaningSuppliesPageState extends State<CleaningSuppliesPage>{

  Widget _buildBody(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => CleaningSuppliesForm());
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }

}