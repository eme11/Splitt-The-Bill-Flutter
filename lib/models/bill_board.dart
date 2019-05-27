class BillBoard {
  String id;
  String title;
  String descrition;
  bool type;
  double expirationTime;
  String userId;
  int yesVote;
  int noVote;

  BillBoard(this.title, this.descrition, this.type, this.expirationTime, this.userId, this.yesVote, this.noVote, {this.id});

  void incrementYesVote(){
    yesVote += 1;
  }

  void incrementNoVote(){
    noVote += 1;
  }

  Map<String, dynamic> getBillBoardMap(){
    final Map<String, dynamic> _value ={
      'title':title,
      'description':descrition,
      'type':type,
      'expiration':expirationTime,
      'userId':userId,
      'no':noVote,
      'yes':yesVote
    };
    return _value;
  }

  void setId(String value){
    id = value;
  }
}
