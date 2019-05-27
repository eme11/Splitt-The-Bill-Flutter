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
      _supplies.add(supply);
      notifyListeners();
    });
  }

  void deleteSupplyAt(int index) {
    _isLoading = true;
    final String id = _supplies.elementAt(index).id;
    _supplies.removeAt(index);
    http
        .delete(
        'https://split-the-bill-flutter.firebaseio.com/cleaning_supply/${id}.json')
        .then((http.Response response) {
      fetchCleaningSupplies();
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteSupply(CleainingSupply supply) {
    _isLoading = true;
    _supplies.remove(supply);
    notifyListeners();
  }

  bool get isLoading {
    return _isLoading;
  }

  void fetchCleaningSupplies() {
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
          productId,
          data['name'],
          data['type'],
          data['price'],
          userId: data['userId'],
          aid: data['aid']
        );
        fetchedList.add(product);
      });
      _supplies = fetchedList;
      _isLoading = false;
      notifyListeners();
    });
  }
}
