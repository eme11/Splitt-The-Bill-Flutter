import 'package:flutter/material.dart';

class ChangeThemePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChangeThemePageState();
  }

}

class _ChangeThemePageState extends State<ChangeThemePage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildBody(){
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Change Theme'),
      ),
      body: _buildBody(),
    );
  }

}