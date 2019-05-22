import 'package:flutter/material.dart';
import '../widgets/ui_elements/themed_button.dart';

class ChangeThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeThemePageState();
  }
}

class _ChangeThemePageState extends State<ChangeThemePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<String>> _colors = [];
  List<DropdownMenuItem<bool>> _brigtness = [];
  Map<String, dynamic> _formData = {'name': null, 'color': null, 'dark': null};

  DropdownMenuItem<String> _buildDropDownItem(String value, Color backround) {
    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              minRadius: 3.0, child: Icon(Icons.color_lens, color: backround), backgroundColor: backround,),
          SizedBox(
            width: 5.0,
          ),
          Text(value),
        ],
      ),
    );
  }

  DropdownMenuItem<bool> _buildDropDownItemBrightness(
      bool value, Color backround) {
    return DropdownMenuItem<bool>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
              minRadius: 3.0, child: Icon(Icons.more_horiz,), backgroundColor: backround,),
          SizedBox(
            width: 5.0,
          ),
          value ? Text('Dark') : Text('Light'),
        ],
      ),
    );
  }

  Widget _buildDropDownColorList() {
    _colors = [];
    _colors.add(_buildDropDownItem('Red', Colors.red));
    _colors.add(_buildDropDownItem('Dark Orange', Colors.deepOrange));
    _colors.add(_buildDropDownItem('Light Orange', Colors.orange));
    _colors.add(_buildDropDownItem('Gold', Colors.amber));
    _colors.add(_buildDropDownItem('Yellow', Colors.yellow));
    _colors.add(_buildDropDownItem('Dark Pink', Colors.pink));
    _colors.add(_buildDropDownItem('Light Pink', Colors.pinkAccent));
    _colors.add(_buildDropDownItem('Cyclam', Colors.purpleAccent));
    _colors.add(_buildDropDownItem('Light Purple', Colors.purple));
    _colors.add(_buildDropDownItem('Dark Purple', Colors.deepPurple));
    _colors.add(_buildDropDownItem('Light Blue', Colors.lightBlueAccent));
    _colors.add(_buildDropDownItem('Dark Blue', Colors.blueAccent));
    _colors.add(_buildDropDownItem('Green', Colors.green));
    _colors.add(_buildDropDownItem('Green Accent', Colors.greenAccent));
    _colors.add(_buildDropDownItem('Black', Colors.black));
    _colors.add(_buildDropDownItem('Gray', Colors.grey));
    _colors.add(_buildDropDownItem('White', Colors.white));

    return DropdownButtonFormField(
      value: _formData['name'],
      items: _colors,
      hint: Text('Select a color'),
      onChanged: (value) => setState(() {
            _formData['name'] = value;
          }),
    );
  }

  Widget _buildDropDownBrightnessList() {
    _brigtness = [];
    _brigtness.add(_buildDropDownItemBrightness(true, Colors.black54));
    _brigtness.add(_buildDropDownItemBrightness(false, Colors.white));

    return DropdownButtonFormField(
        value: _formData['dark'],
        items: _brigtness,
        hint: Text('Select a theme'),
        onChanged: (value) => setState(() {
              _formData['dark'] = value;
            }));
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildButton(){
    return ThemedButton(_submitForm, 'Change Theme');
  }

  void _submitForm(){

  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              _buildDropDownColorList(),
              _buildSizedBox(),
              _buildDropDownBrightnessList(),
              _buildSizedBox(),
              _buildButton()
            ],
          ),
        ),
      ),
    );
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
