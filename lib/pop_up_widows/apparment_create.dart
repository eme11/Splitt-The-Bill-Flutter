import 'package:flutter/material.dart';

class ApartmentCreate extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _ApartmentCreateState();
  }
}

class _ApartmentCreateState extends State<ApartmentCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> userList = [];
  Map<String, dynamic> _address = {
    'city': null,
    'country': null,
    'street': null,
    'building': null,
    'number': 0
  };

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildStreet() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Street Address', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid Street name';
        }
      },
      onSaved: (String value) {
        _address['street'] = value;
      },
    );
  }

  Widget _buildCountry() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Country', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid country name';
        }
      },
      onSaved: (String value) {
        _address['country'] = value;
      },
    );
  }

  Widget _buildCity() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'City', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid city name';
        }
      },
      onSaved: (String value) {
        _address['city'] = value;
      },
    );
  }

  Widget _buildNumber() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Number', filled: true, fillColor: Colors.white),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Invalid number';
        }
      },
      onSaved: (String value) {
        _address['number'] = value;
      },
    );
  }

  void _addCurrentUser() {
    return userList.add({
      'lastName': 'Mathe',
      'firstName': 'Emese',
      'nickName': 'Eme',
      'number': '0740797202',
      'email': 'emese.mathe.07@gmail.com'
    });
  }

  Widget _buildBody(BuildContext context) {
    _addCurrentUser();
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildStreet(),
            _buildSizedBox(),
            _buildSizedBox(),
            _buildNumber(),
            _buildSizedBox(),
            _buildCity(),
            _buildSizedBox(),
            _buildCountry(),
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
