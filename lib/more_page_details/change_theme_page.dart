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
  Color _currentColor = Colors.red;
  bool _dark = false;

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

    return DropdownButtonFormField(
      value: _currentColor,
      items: _colors,
      hint: Text('Select a color'),
      onChanged: (value) => setState(() {
            _currentColor = value;
          }),
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildChangeColor() {
    return ThemedButton(_changeColor, 'Change Color');
  }

  Widget _buildDarkSwitch() {
    return SwitchListTile(
      value: _dark,
      onChanged: (bool value) {
        setState(() {
          _dark = value;
        });
        if (_dark) {
          changeBrightness(Brightness.dark);
        } else {
          changeBrightness(Brightness.light);
        }
      },
      title: Text('Dark theme'),
    );
  }

  void _changeColor() {
    changeColor(_currentColor);
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
                  _buildDarkSwitch(),
                  _buildSizedBox(),
                  _buildDropDownColorList(),
                  _buildSizedBox(),
                  _buildChangeColor(),
                  _buildSizedBox(),
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
