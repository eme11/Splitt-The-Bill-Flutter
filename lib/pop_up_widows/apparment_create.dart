import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../helpers/regular_expressions.dart';
import '../models/apartment.dart';

import '../scoped_models/main_model.dart';

class ApartmentCreate extends StatefulWidget {
  final Function isNew;
  final String title;

  ApartmentCreate(this.isNew, {this.title = 'Create'});

  @override
  State<StatefulWidget> createState() {
    return _ApartmentCreateState();
  }
}

class _ApartmentCreateState extends State<ApartmentCreate> {
  Apartment _apartment = Apartment('', '', 0, '', '');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> userList = [];

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildStreet(MainModel model) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Street Address',
      ),
      initialValue: model.currentApartmnet.streetName == null
          ? ''
          : model.currentApartmnet.streetName,
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

  Widget _buildCountry(MainModel model) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Country',
      ),
      initialValue: model.currentApartmnet.country == null
          ? ''
          : model.currentApartmnet.country,
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

  Widget _buildCity(MainModel model) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'City',
      ),
      initialValue: model.currentApartmnet.city == null
          ? ''
          : model.currentApartmnet.city,
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

  Widget _buildNumber(MainModel model) {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Number'),
      initialValue: model.currentApartmnet.number == null
          ? 0
          : model.currentApartmnet.number.toString(),
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

  Widget _buildBody(BuildContext context, MainModel model) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildStreet(model),
            _buildSizedBox(),
            _buildSizedBox(),
            _buildNumber(model),
            _buildSizedBox(),
            _buildCity(model),
            _buildSizedBox(),
            _buildCountry(model),
          ],
        ),
      ),
    );
  }

  void _submitForm(MainModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    if (!widget.isNew()) {
      print('aaaaaa');
      await model.addApartment(_apartment).then((bool) {
        model.addCurrentUserAid(model.currentApartmnet.id);
        Navigator.of(context).pop();
      });
    } else {
      model.updateAddress(_apartment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text(widget.title),
        content: _buildBody(context, model),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _submitForm(model);
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
    });
  }
}
