import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';

mixin UserModel on Model{
  User _currentUser =  User('4', 'Emese', 'Mathe', 'Eme', 'emese@gmaill.com', '0740797202');

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

  void registerUser(User user){
    final Map<String, dynamic> userMap = user.getUserMap();
    http
        .post(
        'https://split-the-bill-flutter.firebaseio.com/user_information.json',
        body: json.encode(userMap));
  }

}