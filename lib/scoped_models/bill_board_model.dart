import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/bill_board.dart';

mixin BillBoardModel on Model {
  List<BillBoard> _announcements = [];
  bool _isLoading = false;

  bool get isBillBoardLoading {
    return _isLoading;
  }

  List<BillBoard> get announcement {
    return List.from(_announcements);
  }

  void addAnnouncements(BillBoard announcement) {
    final Map<String, dynamic> value = announcement.getBillBoardMap();
    http
        .post('https://split-the-bill-flutter.firebaseio.com/bill_board.json',
            body: json.encode(value))
        .then((http.Response response) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      announcement.setId(responseData['name']);
      _announcements.add(announcement);
      notifyListeners();
    });
  }

  void incrementPoll(int index, {bool yes = true}) {
    if (yes) {
      _announcements.elementAt(index).incrementYesVote();
    } else {
      _announcements.elementAt(index).incrementNoVote();
    }
    final String id = _announcements.elementAt(index).id;
    final Map<String, dynamic> updateData =
        _announcements.elementAt(index).getBillBoardMap();
    http
        .put(
            'https://split-the-bill-flutter.firebaseio.com/bill_board/${id}.json',
            body: json.encode(updateData))
        .then((http.Response reponse) {
      _isLoading = false;
      notifyListeners();
    });
  }

  void deleteAnnouncementAt(int index) {
    _isLoading = true;
    notifyListeners();
    final String id = _announcements.elementAt(index).id;
    http
        .delete(
        'https://split-the-bill-flutter.firebaseio.com/bill_board/$id.json')
        .then((http.Response response) {
      _announcements.removeAt(index);
      fetchBillBoard();
      _isLoading = false;
      notifyListeners();
    });
  }

  void fetchBillBoard() {
    _isLoading = true;
    notifyListeners();
    http
        .get(
        'https://split-the-bill-flutter.firebaseio.com/bill_board.json')
        .then((http.Response response) {
      final List<BillBoard> fetchedList = [];
      final Map<String, dynamic> listData = json.decode(response.body);
      if (listData == null) {
        _isLoading = false;
        notifyListeners();
        return;
      }
      listData.forEach((String productId, dynamic data) {
        final BillBoard product = BillBoard(
            productId,
            data['title'],
            data['description'],
            data['type'],
            data['expiration'],
            data['yes'],
            data['no'],
            userNickName: data['userNickName'],
            userId: data['userId'],
            aid: data['aid']
        );
        fetchedList.add(product);
      });
      _announcements = fetchedList;
      _isLoading = false;
      notifyListeners();
    });
  }
}
