import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

import '../models/cleaning_suppliy.dart';

mixin SupplyModel on Model{
  List<CleainingSupply> _supplies = [];

  List<CleainingSupply> get supplies{
    return List.from(_supplies);
  }

  void addSupply(CleainingSupply supply){
    _supplies.add(supply);
    notifyListeners();
  }

  void deleteSupplyAt(int index){
    _supplies.removeAt(index);
    notifyListeners();
  }

  void deleteSupply(CleainingSupply supply){
    _supplies.remove(supply);
    notifyListeners();
  }
}