import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../scoped_models/main_model.dart';
import '../helpers/regular_expressions.dart';
import '../widgets/ui_elements/themed_button.dart';
import '../pop_up_widows/forgot_password_form.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  Map<String, String> signIn = {'email': null, 'password': null};
  Function _login;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'E-Mail'),
      initialValue: signIn['email'],
      validator: (String value) {
        if (value.isEmpty || RegularExpressions.isEmail(value)) {
          return 'Input should be a valid email.';
        }
      },
      onSaved: (String value) {
        signIn['email'] = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
      initialValue: signIn['password'],
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password too short.';
        }
      },
      onSaved: (String value) {
        signIn['password'] = value;
      },
    );
  }

  Widget _buildSignInButton() {
    return ThemedButton(_signIn, 'SIGN IN');
  }

  Widget _buildRegisterButton() {
    return ThemedTextButton(_signUp, 'NO ACCOUNT? SIGN UP');
  }

  Widget _buildForgotPassword() {
    return ThemedTextButton(_openForgotPassword, 'FORGOT PASSWORD');
  }

  void _openForgotPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) => ForgotPasswordForm());
  }

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  void _signUp() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  void _fetchData(String email) async {
    MainModel model = ScopedModel.of(context);
    await model.fetchCurrentUser(email).then((bool value) async {
      await model.fetchCurrentApartment(model.currentUser.aid);
      model.fetchUsersForApartment();
      model.fetchBillBoard();
      model.fetchChoreList();
      model.fetchCleaningSupplies(model.currentApartmnet.id);
    });
  }

  void _signIn() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Map<String, dynamic> successInformation;
    successInformation = await _login(signIn['email'], signIn['password']);
    if (successInformation['success']) {
      Navigator.pushReplacementNamed(context, '/application');
      _fetchData(signIn['email']);
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

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: <Widget>[
                  _buildEmailField(),
                  _buildSizedBox(),
                  _buildPassword(),
                  _buildSizedBox(),
                  _buildSignInButton(),
                  _buildSizedBox(),
                  _buildRegisterButton(),
                  _buildSizedBox(),
                  _buildForgotPassword()
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
        title: Text('Sign In'),
      ),
      body: ScopedModelDescendant(
          builder: (BuildContext context, Widget child, MainModel model) {
        _login = model.authenticate;
        return _buildBody();
      }),
    );
  }
}
