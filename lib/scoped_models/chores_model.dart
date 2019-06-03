import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/chores.dart';

mixin ChoresModel on Model {
  List<Chore> _chores = [];
  bool _isLoading = false;

  bool get isChoreLoading {
    return _isLoading;
  }

  List<Chore> get chores {
    return List.from(_chores);
  }

  void addChore(Chore chore) {
    final Map<String, dynamic> choreMap = chore.getChoreMap();
    http
        .post('https://split-the-bill-flutter.firebaseio.com/chores.json',
            body: json.encode(choreMap))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      chore.setId(responseData['name']);
      _chores.add(chore);
      _isLoading = false;
      notifyListeners();
    });
  }

  void changeChoreInterval(String aid, int interval) async {
    for (int i = 0; i < _chores.length; ++i) {
      _chores[i].setInterval(interval);
      final Map<String, dynamic> value = _chores[i].getChoreMap();
      await http
          .put(
              'https://split-the-bill-flutter.firebaseio.com/chores/${_chores[i].id}.json',
              body: json.encode(value))
          .then((http.Response response) {
        fetchChoreList();
      });
    }
  }

  void deleteChoreAt(int index) {
    _isLoading = true;
    notifyListeners();
    final String id = _chores.elementAt(index).id;
    http
        .delete(
            'https://split-the-bill-flutter.firebaseio.com/chores/$id.json')
        .then((http.Response response) {
      _chores.removeAt(index);
      fetchChoreList();
      _isLoading = false;
      notifyListeners();
    });
  }

  void fetchChoreList() {
    _isLoading = true;
    notifyListeners();
    http
        .get('https://split-the-bill-flutter.firebaseio.com/chores.json')
        .then((http.Response response) {
      final List<Chore> fetchedList = [];
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      listData.forEach((String productId, dynamic data) {
        Chore product = Chore(
            data['name'], data['description'], data['changingInterval'],
            id: productId,
            currentAssigneeId: data['currentAssigneeId'],
            aid: data['aid'],
            initals: data['initials']);
        fetchedList.add(product);
      });
      _chores = fetchedList;
      _isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }
}
