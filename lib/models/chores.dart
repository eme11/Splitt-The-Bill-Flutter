class Chore{
  String aid;
  String id;
  String name;
  String description;
  int changingInterval;
  String currentAssigneeId;

  Chore(this.name, this.description, this.changingInterval, {this.id, this.aid, this.currentAssigneeId});

  void setCurrentAssigneeId(String uid){
    currentAssigneeId = uid;
  }

  String get currentAssigneeUid{
    return currentAssigneeId;
  }

  void setApartmentId(String id){
    aid = id;
  }

  String get apartmentId{
    return aid;
  }

  void setId(String value){
    id = value;
  }

  Map<String, dynamic> getChoreMap(){
    final Map<String, dynamic> chore  = {
      'aid':aid,
      'name':name,
      'description':description,
      'changingInterval':changingInterval,
      'currentAssigneeId':currentAssigneeId
    };
    return chore;
  }
}