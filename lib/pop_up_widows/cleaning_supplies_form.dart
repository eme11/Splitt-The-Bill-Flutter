import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../helpers/regular_expressions.dart';
import '../models/cleaning_suppliy.dart';

import '../scoped_models/main_model.dart';

class CleaningSuppliesForm extends StatefulWidget {
  final Function addSupply;

  CleaningSuppliesForm(this.addSupply);

  @override
  State<StatefulWidget> createState() {
    return _CleaningSuppliesFormState();
  }
}

class _CleaningSuppliesFormState extends State<CleaningSuppliesForm> {
  List<DropdownMenuItem<String>> _type = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CleainingSupply _formData = CleainingSupply('ff', '', 'Bathroom', 0.0);

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Name',
      ),
      validator: (String value) {
        if (value.isEmpty || value.length < 4) {
          return 'Name too short';
        }
      },
      onSaved: (String value) {
        _formData.name = value;
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
    _type.add(_buildDropDownItem('Bathroom', Icons.invert_colors));
    _type.add(_buildDropDownItem('Kitchen', Icons.free_breakfast));
    _type.add(_buildDropDownItem('Living', Icons.event_seat));
    _type.add(_buildDropDownItem('Other', Icons.more_horiz));

    return DropdownButtonFormField(
      value: _formData.type,
      items: _type,
      hint: Text('Select a type'),
      onChanged: (value) => _typeChanged(value),
    );
  }

  void _typeChanged(String newSelection) {
    setState(() {
      _formData.type = newSelection;
    });
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildPrice() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Price'),
      initialValue: _formData.price == null ? '' : _formData.price.toString(),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isRealNumber(value)) {
          return 'Input should be a number.';
        }
      },
      onSaved: (String value) {
        _formData.price = double.parse(value);
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _buildName(),
            _buildSizedBox(),
            _buildDropDownTypeList(),
            _buildSizedBox(),
            _buildPrice()
          ],
        ),
      ),
    );
  }

  void _submitForm(String uid, String aid, String nickName) {
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formData.setCleaningUID(uid);
    _formData.setApartmentId(aid);
    _formData.setBuyerNickName(nickName);
    _formKey.currentState.save();
    widget.addSupply(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0))),
        title: Text('Create'),
        content: _buildBody(context),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _submitForm(model.uid, model.currentApartmnet.id,
                  model.currentUser.nickName);
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
    });
  }
}
