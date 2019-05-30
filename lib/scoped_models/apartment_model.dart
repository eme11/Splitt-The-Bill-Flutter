import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/apartment.dart';
import '../models/user.dart';

mixin ApartmentModel on Model {
  Apartment _currentApartment =
      Apartment('', '', 0, '', '');
  List<User> _userList = [
    User('5', 'Emese', 'Mathe', 'Eme', '0740797202', 'emese@e.e'),
    User('5', 'Noemi', 'Mathe', 'Noci', '074022222', 'nnnn@e.e'),
    User('5', 'fggre', 'Mathe', 'Eme', '0740444444', 'grger@e.e')
  ];
  bool _isLoading;

  List<User> get userList {
    return List.from(_userList);
  }

  bool get isApartmentLoading {
    return _isLoading;
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

  void addApartment(Apartment apartment){
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> value = apartment.getApartmentMap();
    http
        .post(
        'https://split-the-bill-flutter.firebaseio.com/apartment_info.json',
        body: json.encode(value))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      apartment.setId(responseData['name']);
      _currentApartment = apartment;
      fetchCurrentApartment();
      _isLoading = false;
      notifyListeners();
    });
  }

  Apartment get currentApartmnet {
    return _currentApartment;
  }

  void setcurrentApartment(Apartment apartment) {
    _currentApartment = apartment;
  }

  void fetchCurrentApartment(){
    _isLoading = true;
    notifyListeners();
    http
        .get('https://split-the-bill-flutter.firebaseio.com/apartment_info.json')
        .then((http.Response response) {
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      listData.forEach((String productId, dynamic data) {
        if (productId == _currentApartment.id) {
          _currentApartment = Apartment(
            productId,
            data['street'],
            data['number'],
            data['city'],
            data['country']
          );
          _isLoading = false;
          notifyListeners();
          return;
        }
      });
      _isLoading = false;
      notifyListeners();
    });
  }
}
