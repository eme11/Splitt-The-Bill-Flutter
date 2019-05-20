import 'package:flutter/material.dart';
import '../widgets/more_list_titles/user_list_title.dart';
import '../widgets/more_list_titles/simple_list_title.dart';
import '../more_page_details/account_page.dart';

class MorePage extends StatelessWidget {
  List<Widget> _initlizeList() {
    List<Widget> _returnList = [];

    _returnList.add(UserListTitle('Emese', 'Mathe',openNewPage,AccountInformation(),));
    _returnList.add(SimpleListTitle('My Apartment', Icons.home),);
    _returnList.add(SimpleListTitle('Chat', Icons.chat));
    _returnList.add(SimpleListTitle('Change Theme', Icons.mode_edit));
    _returnList.add(SimpleListTitle('Settings', Icons.settings));
    _returnList.add(SimpleListTitle('About', Icons.info));
    _returnList.add(SimpleListTitle('Report issue', Icons.warning));

    return _returnList;
  }

  void openNewPage(BuildContext context,Widget pageName){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pageName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> moreList = _initlizeList();
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[moreList[index]],
        );
      },
      itemCount: moreList.length,
    );
  }
}
