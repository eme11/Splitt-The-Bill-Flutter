import 'dart:convert';
import 'dart:async';

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
    chore.setLastAssignedTime(DateTime.now());
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
          'https://split-the-bill-flutter.firebaseio.com/chores/${_chores[i]
              .id}.json',
          body: json.encode(value))
          .then((http.Response response) {
        fetchChoreList();
      });
    }
  }

  Future<void> updateChore(Chore chore) async{
    final Map<String, dynamic> value = chore.getChoreMap();
    http
        .put(
        'https://split-the-bill-flutter.firebaseio.com/chores/${chore.id}.json',
        body: json.encode(value));
  }

  void deleteChoreAt(int index) {
    _isLoading = true;
    notifyListeners();
    final String id = _chores
        .elementAt(index)
        .id;
    http
        .delete('https://split-the-bill-flutter.firebaseio.com/chores/$id.json')
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
        Chore product = Chore(data['name'], data['description'],
            data['changingInterval'], DateTime.parse(data['lastAssignedTime']),
            id: productId,
            currentAssigneeId: data['currentAssigneeId'],
            aid: data['aid'],
            initals: data['initials']);
        fetchedList.add(product);
      });
      _chores = fetchedList;
      setTimerForAllChores();
      _isLoading = false;
      notifyListeners();
    });
    notifyListeners();
  }

  void setTimerForAllChores() async {
    Duration timePast = DateTime.now().difference(_chores[0].lastAssignedTime);
    int timeLeft = _chores[0].changingInterval - timePast.inDays;

    Duration timer = Duration(seconds: 10);
    Timer.periodic(timer, (Timer timer)
    {
      reassigningChores();
      notifyListeners();
    });
  }

  void reassigningChores() async{
    String tmp =  _chores.elementAt(_chores.length - 1).initals;
    String uidTmp =  _chores.elementAt(_chores.length - 1).currentAssigneeId;
    for (int i = _chores.length - 1; i > 0; i--) {
      _chores[i].setInitals(_chores[i-1].initals);
      _chores[i].setCurrentAssigneeId(_chores[i-1].currentAssigneeId);
      await updateChore(_chores[i]);
    }

    _chores[0].setInitals(tmp);
    _chores[0].setCurrentAssigneeId(uidTmp);
    await updateChore(chores[0]);
  }
}
