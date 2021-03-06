import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/apartment.dart';
import '../models/user.dart';

mixin ApartmentModel on Model {
  Apartment _currentApartment = Apartment('', '', 0, '', '');
  List<User> _userList = [];
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

  void deleteUserAt(int index, Function updateUserInfo) async {
    _isLoading = true;
    notifyListeners();
    final User user = _userList.elementAt(index);
    _userList.removeAt(index);
    await updateUserInfo(user.id, user.aid);
    _isLoading = false;
    notifyListeners();
  }

  void deleteUser(User user, Function updateUserInfo) async {
    _isLoading = true;
    notifyListeners();
    int index = _userList.indexOf(user);
    _userList.removeAt(index);
    print(_userList.length.toString());
    await updateUserInfo(user).then((bool value) {
      if (value) {
        //fetchUsersForApartment();
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<bool> addApartment(Apartment apartment) {
    _isLoading = true;
    notifyListeners();
    final Map<String, dynamic> value = apartment.getApartmentMap();
    return http
        .post(
            'https://split-the-bill-flutter.firebaseio.com/apartment_info.json',
            body: json.encode(value))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      apartment.setId(responseData['name']);
      _currentApartment = apartment;
      fetchCurrentApartment(_currentApartment.id);
      _isLoading = false;
      notifyListeners();
      return true;
    });
  }

  void updateAddress(Apartment apartment) {
    Map<String, dynamic> value = apartment.getApartmentMap();
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/apartment_info/${_currentApartment.id}.json',
            body: json.encode(value))
        .then((http.Response reponse) {
      _currentApartment = apartment;
      notifyListeners();
      return true;
    }).catchError((error) {
      notifyListeners();
      return false;
    });
  }

  Apartment get currentApartmnet {
    return _currentApartment;
  }

  void setcurrentApartment(Apartment apartment) {
    _currentApartment = apartment;
  }

  Future<bool> fetchCurrentApartment(String aid) {
    _isLoading = true;
    notifyListeners();
    return http
        .get(
            'https://split-the-bill-flutter.firebaseio.com/apartment_info/$aid.json')
        .then((http.Response response) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
      _currentApartment = Apartment(
          aid, data['street'], data['number'], data['city'], data['country']);
      _isLoading = false;
      notifyListeners();
      return true;
    });
  }

  void fetchUsersForApartment() {
    _isLoading = true;
    notifyListeners();
    http
        .get(
            'https://split-the-bill-flutter.firebaseio.com/user_information.json')
        .then((http.Response response) {
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      listData.forEach((String productId, dynamic data) {
        if (_currentApartment.id == data['aid']) {
          final User user = User(productId, data['firstName'], data['lastName'],
              data['nickName'], data['email'], data['number'],
              aid: data['aid']);
          _userList.add(user);
        }
      });
      _isLoading = false;
      notifyListeners();
    });
  }
}
