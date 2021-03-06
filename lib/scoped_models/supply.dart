import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/cleaning_suppliy.dart';

mixin SupplyModel on Model {
  List<CleainingSupply> _supplies = [];
  bool _isLoading = false;

  List<CleainingSupply> get supplies {
    return List.from(_supplies);
  }

  void addSupply(CleainingSupply supply) {
    final Map<String, dynamic> supplyMap = supply.getSupplyMap();
    http
        .post(
            'https://split-the-bill-flutter.firebaseio.com/cleaning_supply.json',
            body: json.encode(supplyMap))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      supply.setId(responseData['name']);
      _supplies.add(supply);
      notifyListeners();
    });
  }

  void deleteSupplyAt(int index, String aid) {
    _isLoading = true;
    notifyListeners();
    final String id = _supplies.elementAt(index).id;
    http
        .delete(
            'https://split-the-bill-flutter.firebaseio.com/cleaning_supply/$id.json')
        .then((http.Response response) {
      _supplies.removeAt(index);
      fetchCleaningSupplies(aid);
      _isLoading = false;
      notifyListeners();
    });
  }

  bool get isLoading {
    return _isLoading;
  }

  Future _deleteAllSupplies() async {
    _isLoading = true;
    notifyListeners();
    print('AAAAAAAAAA ' + _supplies.length.toString());
    for (int i = 0; i < _supplies.length; ++i) {
      await http
          .delete(
              'https://split-the-bill-flutter.firebaseio.com/cleaning_supply/${_supplies[i].id}.json')
          .then((http.Response response) {
        print(response);
        _isLoading = false;
        notifyListeners();
      });
    }
  }

  void deleteAndFetch(String aid) async {
    _isLoading = true;
    notifyListeners();
    _deleteAllSupplies().whenComplete(() {
      _supplies = [];
      fetchCleaningSupplies(aid);
      _isLoading = false;
      notifyListeners();
    });
  }

  void fetchCleaningSupplies(String aid) {
    _isLoading = true;
    notifyListeners();
    http
        .get(
            'https://split-the-bill-flutter.firebaseio.com/cleaning_supply.json')
        .then((http.Response response) {
      final List<CleainingSupply> fetchedList = [];
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      listData.forEach((String productId, dynamic data) {
        final CleainingSupply product = CleainingSupply(
            productId, data['name'], data['type'], data['price'],
            userId: data['userId'],
            buyerNickName: data['buyerNickName'],
            aid: data['aid']);
        if (data['aid'] == aid) fetchedList.add(product);
      });
      _supplies = fetchedList;
      _isLoading = false;
      notifyListeners();
    });
  }
}
