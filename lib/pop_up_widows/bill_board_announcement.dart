import 'package:flutter/material.dart';
import '../helpers/regular_expressions.dart';

class BillBoardForm extends StatefulWidget {
  final Function addToBillBoard;

  BillBoardForm(this.addToBillBoard);

  @override
  State<StatefulWidget> createState() {
    return _BillBoardFormState();
  }
}

class _BillBoardFormState extends State<BillBoardForm> {
  List<DropdownMenuItem<bool>> _type = [];
  Map<String, dynamic> _formData = {
    'title': null,
    'type': false,
    'description': null,
    'expiration': 24,
    'user':'anonymous_user'
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Title', filled: true, fillColor: Colors.white),
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

  Widget _buildDropDownTypeList() {
    _type = [];
    _type.add(DropdownMenuItem<bool>(
      value: true,
      child: Text(
        'Poll',
      ),
    ));
    _type.add(DropdownMenuItem<bool>(
      value: false,
      child: Text(
        'Announcement',
      ),
    ));

    return DropdownButtonFormField(
      value: _formData['type'],
      items: _type,
      hint: Text('Select a type'),
      onChanged: (value) => _typeChanged(value),
    );
  }

  void _typeChanged(bool newSelection) {
    setState(() {
      _formData['type'] = newSelection;
    });
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

  Widget _buildExpirationField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Expiration(hours)'),
      initialValue: _formData['expiration'] == null
          ? ''
          : _formData['expiration'].toString(),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isRealNumber(value)) {
          return 'Input should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['expiration'] = double.parse(value);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildTitleTextField(),
            _buildSizedBox(),
            _buildDropDownTypeList(),
            _buildSizedBox(),
            _buildDescription(),
            _buildSizedBox(),
            _buildExpirationField(),
            _buildSizedBox()
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();
    widget.addToBillBoard(_formData);
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
