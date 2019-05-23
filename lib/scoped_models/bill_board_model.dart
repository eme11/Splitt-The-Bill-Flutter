import 'package:scoped_model/scoped_model.dart';
import '../models/bill_board.dart';

mixin BillBoardModel on Model{
  List<BillBoard> _announcements;

  List<BillBoard> get announcement{
    return List.from(_announcements);
  }

  void addAnnouncements(BillBoard announcement){
    _announcements.add(announcement);
    notifyListeners();
  }

  void deleteAnnouncementAt(int index){
    _announcements.removeAt(index);
    notifyListeners();
  }

  void deleteAnnouncement(BillBoard announcement){
    _announcements.remove(announcement);
    notifyListeners();
  }


}