import 'package:scoped_model/scoped_model.dart';
import '../models/cleaning_suppliy.dart';

mixin SupplyModel on Model{
  List<CleainingSupply> _supplies = [];

  List<CleainingSupply> get supplies{
    return List.from(_supplies);
  }

  void addSupply(CleainingSupply supply){
    _supplies.add(supply);
  }

  void deleteSupplyAt(int index){
    _supplies.removeAt(index);
  }

  void deleteSupply(CleainingSupply supply){
    _supplies.remove(supply);
  }
}