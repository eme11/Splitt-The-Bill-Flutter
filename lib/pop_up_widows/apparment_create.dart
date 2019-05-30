import 'package:flutter/material.dart';
import '../helpers/regular_expressions.dart';
import '../models/apartment.dart';
import '../models/user.dart';

class ApartmentCreate extends StatefulWidget {
  final Function isNew;
  final Function addUser;
  final Function addAddress;
  final String title;
  final Apartment apartment;

  ApartmentCreate(this.apartment, this.isNew, this.addAddress, this.addUser,
      {this.title = 'Create'});

  @override
  State<StatefulWidget> createState() {
    return _ApartmentCreateState();
  }
}

class _ApartmentCreateState extends State<ApartmentCreate> {
  Apartment _apartment = Apartment('b', '', 0, '', '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> userList = [];

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildStreet() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Street Address',
      ),
      initialValue: widget.apartment.streetName == null
          ? ''
          : widget.apartment.streetName,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid Street name';
        }
      },
      onSaved: (String value) {
        _apartment.streetName = value;
      },
    );
  }

  Widget _buildCountry() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Country',
      ),
      initialValue:
          widget.apartment.country == null ? '' : widget.apartment.country,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid country name';
        }
      },
      onSaved: (String value) {
        _apartment.country = value;
      },
    );
  }

  Widget _buildCity() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'City',
      ),
      initialValue: widget.apartment.city == null ? '' : widget.apartment.city,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Invalid city name';
        }
      },
      onSaved: (String value) {
        _apartment.city = value;
      },
    );
  }

  Widget _buildNumber() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Number'),
      initialValue: widget.apartment.number == null
          ? 0
          : widget.apartment.number.toString(),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isInteger(value)) {
          return 'Invalid number';
        }
      },
      onSaved: (String value) {
        _apartment.number = int.parse(value);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
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

    if (widget.isNew()) {
      widget.addUser(User('fff', 'Admin', 'Blah', 'example', '0755555555',
          'something@gmail.com'));
    }
    widget.addAddress(_apartment);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0))),
      title: Text(widget.title),
      content: _buildBody(context),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _submitForm();
          },
          child: widget.title == 'Create' ? Text('ADD') : Text('EDIT'),
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
