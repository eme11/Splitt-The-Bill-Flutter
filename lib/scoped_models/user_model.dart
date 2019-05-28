import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import '../helpers/auth_mode.dart';

mixin UserModel on Model{
  User _currentUser =  User('4', 'Emese', 'Mathe', 'Eme', 'emese@gmaill.com', '0740797202');
  bool _isLoading = false;

  bool get isApplicationLoading{
    return _isLoading;
  }


  User get currentUser{
    return _currentUser;
  }

  void set currentUser(User user){
    _currentUser = user;
  }

  void updateFirstName(String firstName){
    _currentUser.firstName = firstName;
    notifyListeners();
  }

  void updateLastName(String lastName){
    _currentUser.lastName = lastName;
    notifyListeners();
  }

  void updateNickName(String nickName){
    _currentUser.nickName = nickName;
    notifyListeners();
  }

  void updateNumber(String number){
    _currentUser.phone = number;
    notifyListeners();
  }

  String get uid {
    return _currentUser.id;
  }

  void registerUser(User user, String password){
    final Map<String, dynamic> userMap = user.getUserMap();
    http
        .post(
        'https://split-the-bill-flutter.firebaseio.com/user_information.json',
        body: json.encode(userMap));
    authenticate(user.email, password, AuthMode.Register);
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    http.Response response;
    if (mode == AuthMode.Login) {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/verifyPassword?key=AIzaSyDFVzAhNLSxobJRdMA9h1s7IrUxre5RMc8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    } else {
      response = await http.post(
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/signupNewUser?key=AIzaSyDFVzAhNLSxobJRdMA9h1s7IrUxre5RMc8',
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = 'Something went wrong.';
    print(responseData);
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email already exists.';
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'This email was not found.';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'The password is invalid.';
    }
    _isLoading = false;
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }

}