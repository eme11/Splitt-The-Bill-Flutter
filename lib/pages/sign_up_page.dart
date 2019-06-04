import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import '../widgets/ui_elements/themed_button.dart';
import '../helpers/regular_expressions.dart';

import '../scoped_models/main_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  User _user = User('7', '', '', '', '', '');
  String _password = '';
  bool _accepted = false;
  Function _register;

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'E-Mail'),
      controller: _emailTextController,
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isEmail(value)) {
          return 'Input should be a valid email.';
        }
      },
      onSaved: (String value) {
        _user.email = value;
      },
    );
  }

  Widget _buildEmailConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Email'),
      validator: (String value) {
        if (_emailTextController.text != value) {
          return 'Emails do not match.';
        }
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Passwords do not match.';
        }
      },
    );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'First Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input should be a empty.';
        }
      },
      onSaved: (String value) {
        _user.firstName = value;
      },
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Last Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input should be a empty.';
        }
      },
      onSaved: (String value) {
        _user.lastName = value;
      },
    );
  }

  Widget _buildNickNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Nick Name'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Input should be a empty.';
        }
      },
      onSaved: (String value) {
        _user.nickName = value;
      },
    );
  }

  Widget _builPhoneNumberField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone Number'),
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isPhoneNumber(value)) {
          return 'Input should be a valid phone number.';
        }
      },
      onSaved: (String value) {
        _user.phone = value;
      },
    );
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  Widget _buildRegisterButton() {
    return ThemedButton(_submitForm, 'SIGN UP');
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate() || !_accepted) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await _register(_user, _password);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _accepted,
      onChanged: (bool value) {
        setState(() {
          _accepted = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  Widget _buildBody(Function register) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  _buildFirstNameField(),
                  _buildSizedBox(),
                  _buildLastNameField(),
                  _buildSizedBox(),
                  _buildNickNameField(),
                  _buildSizedBox(),
                  _builPhoneNumberField(),
                  _buildSizedBox(),
                  _buildEmailField(),
                  _buildSizedBox(),
                  _buildEmailConfirmTextField(),
                  _buildSizedBox(),
                  _buildPasswordTextField(),
                  _buildSizedBox(),
                  _buildPasswordConfirmTextField(),
                  _buildSizedBox(),
                  _buildAcceptSwitch(),
                  _buildSizedBox(),
                  _buildRegisterButton(),
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
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      _register = model.registerUser;
      return Scaffold(
        appBar: AppBar(
            title: Text('Sign Up'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.pushReplacementNamed(context, '/'))),
        body: _buildBody(model.registerUser),
      );
    });
  }
}
