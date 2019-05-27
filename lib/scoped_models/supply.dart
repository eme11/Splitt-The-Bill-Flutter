import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

import '../models/cleaning_suppliy.dart';

mixin SupplyModel on Model {
  List<CleainingSupply> _supplies = [];

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
    _supplies.removeAt(index);
    notifyListeners();
  }

  void deleteSupply(CleainingSupply supply) {
    _supplies.remove(supply);
    notifyListeners();
  }
}
