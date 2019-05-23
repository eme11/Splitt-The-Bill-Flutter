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

}