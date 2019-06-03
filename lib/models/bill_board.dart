class BillBoard {
  String id;
  String title;
  String descrition;
  bool type;
  double expirationTime;
  String userId;
  String aid;
  String userNickName;
  int yesVote;
  int noVote;

  BillBoard(this.id,this.title, this.descrition, this.type, this.expirationTime,
      this.yesVote, this.noVote,
      {this.userNickName, this.aid, this.userId});

  void incrementYesVote() {
    yesVote += 1;
  }

  void incrementNoVote() {
    noVote += 1;
  }

  Map<String, dynamic> getBillBoardMap() {
    final Map<String, dynamic> _value = {
      'title': title,
      'description': descrition,
      'type': type,
      'expiration': expirationTime,
      'userId': userId,
      'no': noVote,
      'yes': yesVote,
      'userNickName': userNickName,
      'aid':aid
    };
    return _value;
  }

  void setId(String value) {
    id = value;
  }

  void setBillBoardUserId(String value){
    userId = value;
  }

  void setBillBoardUserNickName(String value){
    userNickName = value;
  }

  void setBillBoardAid(String value){
    aid = value;
  }
}
