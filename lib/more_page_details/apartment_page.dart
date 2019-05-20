import 'package:flutter/material.dart';
import '../pop_up_widows/apparment_create.dart';

class ApartmentPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ApartmentPageState();
  }

}

class _ApartmentPageState extends State<ApartmentPage>{

  Widget _buildBody(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Apartment'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => ApartmentCreate());
        },
        child: Icon(Icons.add),
        mini: true,
      ),
    );
  }

}