class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String phone;
  String nickName;

  User(this.id, this.firstName, this.lastName, this.nickName, this.email,
      this.phone);

  Map<String, dynamic> getUserMap(){
    final Map<String, dynamic> _user ={
      'firstName':firstName,
      'lastName':lastName,
      'email':email,
      'number':phone,
      'nickName':nickName,
    };
    return _user;
  }
}
