class Chore{
  String aid;
  String name;
  String description;
  int changingInterval;
  String currentAssigneeId;

  Chore(this.name, this.description, this.changingInterval);

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