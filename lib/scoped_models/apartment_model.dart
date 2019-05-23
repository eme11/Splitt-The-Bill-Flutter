import 'package:scoped_model/scoped_model.dart';

import '../models/apartment.dart';
import '../models/user.dart';

mixin ApartmentModel on Model{
  Apartment _currentApartment = Apartment('2', 'blah blah', 2, 'Timisoara', 'Romania');
  List<User> _userList = [];

  List<User> get userList{
    return List.from(_userList);
  }

  void addUser(User user){
    _userList.add(user);
    notifyListeners();
  }

  void deleteUserAt(int index){
    _userList.removeAt(index);
    notifyListeners();
  }

  void deleteUser(User user){
    _userList.remove(user);
    notifyListeners();
  }

  Apartment get currentApartmnet{
    return _currentApartment;
  }

  void setcurrentApartment(Apartment apartment){
    _currentApartment = apartment;
  }


}