import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';
import '../helpers/auth_mode.dart';

mixin UserModel on Model {
  User _currentUser = User('', '', '', '', '', '');
  bool _isLoading = false;

  bool get isApplicationLoading {
    return _isLoading;
  }

  User get currentUser {
    return _currentUser;
  }

  void set currentUser(User user) {
    _currentUser = user;
  }

  void updateFirstName(String firstName) {
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/user_information/${_currentUser.id}/firstName.json',
            body: json.encode(firstName))
        .then((http.Response reponse) {
      _currentUser.firstName = firstName;
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  void addCurrentUserAid(String aid) {
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/user_information/${_currentUser.id}/aid.json',
            body: json.encode(aid))
        .then((http.Response reponse) {
      _currentUser.aid = aid;
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  void addEmailUserAid(String email, String aid, Function add) async {
    await _fetchUserByEmail(email).then((User user) {
      if (user != null) {
        add(user);
        notifyListeners();
        http
            .put(
                'https://split-the-bill-flutter.firebaseio.com/user_information/${user.id}/aid.json',
                body: json.encode(aid))
            .then((http.Response reponse) {
          notifyListeners();
          return true;
        }).catchError((error) {
          notifyListeners();
          return false;
        });
      }
    });
  }

  Future<bool> deleteUserAid(User user) async {
    user.setAid(null);
    Map<String, dynamic> value = user.getUserMap();
    return await http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/user_information/${user.id}.json',
            body: json.encode(value))
        .then((http.Response response) {
      print(response.body);
      print('FFFFFFFFFFFFF');
      print(user.getUserMap());
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  void updateLastName(String lastName) {
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/user_information/${_currentUser.id}/lastName.json',
            body: json.encode(lastName))
        .then((http.Response reponse) {
      _currentUser.lastName = lastName;
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  void updateNickName(String nickName) {
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/user_information/${_currentUser.id}/nickName.json',
            body: json.encode(nickName))
        .then((http.Response reponse) {
      _currentUser.nickName = nickName;
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  void updateNumber(String number) {
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/user_information/${_currentUser.id}/number.json',
            body: json.encode(number))
        .then((http.Response reponse) {
      _currentUser.phone = number;
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  String get uid {
    return _currentUser.id;
  }

  Future<Map<String, dynamic>> registerUser(User user, String password) async {
    final Map<String, dynamic> userMap = user.getUserMap();
    http.post(
        'https://split-the-bill-flutter.firebaseio.com/user_information.json',
        body: json.encode(userMap));
    return await authenticate(user.email, password, AuthMode.Register);
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
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Authentication succeeded!';
      fetchCurrentUser(email);
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

  Future<bool> fetchCurrentUser(String email) async {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://split-the-bill-flutter.firebaseio.com/user_information.json')
        .then((http.Response response) {
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      listData.forEach((String productId, dynamic data) {
        if (data['email'] == email) {
          _currentUser = User(productId, data['firstName'], data['lastName'],
              data['nickName'], data['email'], data['number']);
          _currentUser.setAid(data['aid']);
          _isLoading = false;
          notifyListeners();
          return true;
        }
      });
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<User> _fetchUserByEmail(String email) async {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://split-the-bill-flutter.firebaseio.com/user_information.json')
        .then((http.Response response) {
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return null;
      }
      User user;
      listData.forEach((String productId, dynamic data) {
        if (data['email'] == email) {
          user = User(productId, data['firstName'], data['lastName'],
              data['nickName'], data['email'], data['number'],
              aid: data['aid']);
          _isLoading = false;
          notifyListeners();
          return;
        }
      });
      _isLoading = false;
      notifyListeners();
      return user;
    });
  }

  Future<String> fetchNickNameFromId(String id) async{
    _isLoading = true;
    notifyListeners();
    return http
        .get(
        'https://split-the-bill-flutter.firebaseio.com/user_information/$id.json')
        .then((http.Response response) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data == null) {
        _isLoading = false;
        notifyListeners();
        return 'anonymous';
      }
      _isLoading = false;
      notifyListeners();
      return data['nickname'];
    });
  }
}
