class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String nickName;
  String aid;

  User(this.id, this.firstName, this.lastName, this.nickName, this.email,
      this.phone, {this.aid});

  Map<String, dynamic> getUserMap(){
    final Map<String, dynamic> _user ={
      'firstName':firstName,
      'lastName':lastName,
      'email':email,
      'number':phone,
      'nickName':nickName,
      'aid':aid
    };
    return _user;
  }

  void setAid(String value){
    this.aid = value;
  }
}
