import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/ui_elements/themed_button.dart';
import '../scoped_models/main_model.dart';
import '../models/user.dart';

class ReportIssuePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReportIssuePageState();
  }
}

class _ReportIssuePageState extends State<ReportIssuePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> _type = [];
  Map<String, dynamic> _formData = {
    'title': null,
    'type': null,
    'description': null
  };
  User _currentUser;

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Title'),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid Title';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 3,
      decoration: InputDecoration(labelText: 'Description'),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Invalid Description';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  DropdownMenuItem<String> _buildDropDownItem(String value, IconData icon) {
    return DropdownMenuItem<String>(
      value: value,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(minRadius: 3.0, child: Icon(icon)),
          SizedBox(
            width: 5.0,
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildDropDownTypeList() {
    _type = [];
    _type.add(_buildDropDownItem('Bug', Icons.bug_report));
    _type.add(_buildDropDownItem('Crash', Icons.close));
    _type.add(_buildDropDownItem('Other', Icons.more_horiz));

    return DropdownButtonFormField(
      value: _formData['type'],
      items: _type,
      hint: Text('Select a type'),
      onChanged: (value) => _typeChanged(value),
    );
  }

  void _typeChanged(String newSelection) {
    setState(() {
      _formData['type'] = newSelection;
    });
  }

  Widget _buildSubmitButton() {
    return ThemedButton(_submitForm, 'Submit Issue');
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
                _buildTitleTextField(),
                _buildSizedBox(),
                _buildDescription(),
                _buildSizedBox(),
                _buildDropDownTypeList(),
                _buildSizedBox(),
                _buildSubmitButton()
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body%20';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _scaffold.currentState.showSnackBar(SnackBar(
        content: new Text("Could not launch $url"),
      ));
    }
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    _launchURL('emese.mathe.07@gmail.com', _formData['type'] + ' : ' + _formData['title'], _formData['description']);
    //_send(_currentUser.email, _formData['type'] + ' : ' + _formData['title'], _formData['description'] );
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Report Issue'),
      ),
      body: ScopedModelDescendant(builder: (BuildContext context, Widget child, MainModel model){
        _currentUser = model.currentUser;
        return _buildBody();
    }),
    );
  }
}
