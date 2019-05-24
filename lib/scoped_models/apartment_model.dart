import 'package:scoped_model/scoped_model.dart';

import '../models/apartment.dart';
import '../models/user.dart';

mixin ApartmentModel on Model {
  Apartment _currentApartment =
      Apartment('2', 'blah blah', 2, 'Timisoara', 'Romania');
  List<User> _userList = [
    User('5', 'Emese', 'Mathe', 'Eme', '0740797202', 'emese@e.e'),
    User('5', 'Noemi', 'Mathe', 'Noci', '074022222', 'nnnn@e.e'),
    User('5', 'fggre', 'Mathe', 'Eme', '0740444444', 'grger@e.e')
  ];

  List<User> get userList {
    return List.from(_userList);
  }

  void addUser(User user) {
    _userList.add(user);
    notifyListeners();
  }

  void deleteUserAt(int index) {
    _userList.removeAt(index);
    notifyListeners();
  }

  void deleteUser(User user) {
    _userList.remove(user);
    notifyListeners();
  }

  Apartment get currentApartmnet {
    return _currentApartment;
  }

  void setcurrentApartment(Apartment apartment) {
    _currentApartment = apartment;
  }
}
