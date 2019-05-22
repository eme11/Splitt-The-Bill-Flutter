import 'package:flutter/material.dart';
import '../helpers/regular_expressions.dart';

class ChoresForm extends StatefulWidget{
  final Function addChore;

  ChoresForm(this.addChore);

  @override
  State<StatefulWidget> createState() {
    return _ChoresFormState();
  }

}

class _ChoresFormState extends State<ChoresForm>{
  List<DropdownMenuItem<String>> _type = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Map<String, dynamic> _formData = {
    'name': null,
    'descrition':null,
    'change_interval': 0,
    'user': 'anonymous_user'
  };

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Name',),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Name too short';
        }
      },
      onSaved: (String value) {
        _formData['name'] = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Descrition',),
      validator: (String value) {
        if (value.isEmpty || value.length < 10) {
          return 'Descrition too short';
        }
      },
      onSaved: (String value) {
        _formData['descrition'] = value;
      },
    );
  }

  Widget _buildChangingInterval(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Changing Interval'),
      initialValue: _formData['change_interval'] == null
          ? ''
          : _formData['change_interval'].toString(),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isInteger(value)) {
          return 'Input should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['change_interval'] = double.parse(value);
      },
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildBody(BuildContext build){
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildName(),
            _buildSizedBox(),
            _buildDescription(),
            _buildSizedBox(),
            _buildChangingInterval()
          ],
        ),
      ),
    );
  }

  void _submitForm(){
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    widget.addChore(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text('Create'),
      content: _buildBody(context),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _submitForm();
          },
          child: Text('ADD'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('CANCEL'),
        )
      ],
    );
  }

}