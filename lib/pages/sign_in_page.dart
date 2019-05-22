import 'package:flutter/material.dart';
import '../helpers/regular_expressions.dart';
import '../widgets/ui_elements/themed_button.dart';

class SignInPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignInPageState();
  }
}

class _SignInPageState extends State<SignInPage> {
  Map<String, String> signIn = {'email': null, 'password': null};

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

  Widget _buildSizedBox() {
    return SizedBox(
      height: 10.0,
    );
  }

  void _signUp() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  void _signIn() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/application');
  }

  Widget _buildBody() {
    return Container(
      margin: EdgeInsets.all(10.0),
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
                _buildRegisterButton()
              ],
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
      body: _buildBody(),
    );
  }
}
