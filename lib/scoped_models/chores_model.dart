import 'package:scoped_model/scoped_model.dart';
import '../models/chores.dart';

mixin ChoresModel on Model{
  List<Chore> _chores = [];

  List<Chore> get chores {
    return List.from(_chores);
  }

  void addChore(Chore chore){
    _chores.add(chore);
    notifyListeners();
  }

  void deleteChoreAt(int index){
    _chores.removeAt(index);
    notifyListeners();
  }

  void deleteChore(Chore chore){
    _chores.remove(chore);
    notifyListeners();
  }
}