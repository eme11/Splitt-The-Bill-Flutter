import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/chores.dart';

mixin ChoresModel on Model{
  List<Chore> _chores = [];

  List<Chore> get chores {
    return List.from(_chores);
  }

  void addChore(Chore chore){
    final Map<String, dynamic> choreMap = chore.getChoreMap();
    http
        .post(
        'https://split-the-bill-flutter.firebaseio.com/chores.json',
        body: json.encode(choreMap))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _chores.add(chore);
      notifyListeners();
    });
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