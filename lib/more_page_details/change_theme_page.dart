import 'package:flutter/material.dart';
import '../widgets/ui_elements/themed_button.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class ChangeThemePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChangeThemePageState();
  }
}

class _ChangeThemePageState extends State<ChangeThemePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem<Color>> _colors = [];
  List<DropdownMenuItem<Brightness>> _brigtness = [];
  Color _currentColor = Colors.red;
  Brightness _currentBrightness = Brightness.light;

  void changeBrightness(Brightness brightness) {
    DynamicTheme.of(context).setBrightness(brightness);
  }

  void changeColor(Color color) {
    DynamicTheme.of(context).setThemeData(ThemeData(primarySwatch: color));
  }

  DropdownMenuItem<Color> _buildDropDownItem(String value, Color backround) {
    return DropdownMenuItem<Color>(
      value: backround,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            minRadius: 3.0,
            child: Icon(Icons.color_lens, color: backround),
            backgroundColor: backround,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(value),
        ],
      ),
    );
  }

  DropdownMenuItem<Brightness> _buildDropDownItemBrightness(
      bool dark, Color backround) {
    return DropdownMenuItem<Brightness>(
      value: dark ? Brightness.dark : Brightness.light,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            minRadius: 3.0,
            child: Icon(
              Icons.more_horiz,
            ),
            backgroundColor: backround,
          ),
          SizedBox(
            width: 5.0,
          ),
          dark ? Text('Dark') : Text('Light'),
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
    _colors.add(_buildDropDownItem('Pink', Colors.pink));
    _colors.add(_buildDropDownItem('Light Purple', Colors.purple));
    _colors.add(_buildDropDownItem('Dark Purple', Colors.deepPurple));
    _colors.add(_buildDropDownItem('Blue', Colors.blue));
    _colors.add(_buildDropDownItem('Green', Colors.green));
    _colors.add(_buildDropDownItem('Light Green', Colors.lightGreen));
    _colors.add(_buildDropDownItem('Black', Colors.black));
    _colors.add(_buildDropDownItem('Gray', Colors.grey));
    _colors.add(_buildDropDownItem('White', Colors.white));

    return DropdownButtonFormField(
      value: _currentColor,
      items: _colors,
      hint: Text('Select a color'),
      onChanged: (value) => setState(() {
            _currentColor = value;
          }),
    );
  }

  Widget _buildDropDownBrightnessList() {
    _brigtness = [];
    _brigtness.add(_buildDropDownItemBrightness(true, Colors.black54));
    _brigtness.add(_buildDropDownItemBrightness(false, Colors.white));

    return DropdownButtonFormField(
        value: _currentBrightness,
        items: _brigtness,
        hint: Text('Select a theme'),
        onChanged: (value) => setState(() {
              _currentBrightness = value;
            }));
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildChangeColor() {
    return ThemedButton(_changeColor, 'Change Color');
  }

  Widget _buildChangeBackGround() {
    return ThemedButton(_changeBrightness, 'Change Background');
  }

  void _changeColor() {
    changeColor(_currentColor);
  }

  void _changeBrightness() {
    changeBrightness(_currentBrightness);
  }

  Widget _buildBody() {
    return Container(
      child: Center(
        child: SingleChildScrollView(
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildChangeBackGround(),
                      _buildChangeColor(),
                    ],
                  ),
                ],
              ),
            ),
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
