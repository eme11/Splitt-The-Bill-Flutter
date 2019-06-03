class Chore {
  String aid;
  String id;
  String name;
  String description;
  int changingInterval;
  String currentAssigneeId;
  String initals;

  Chore(this.name, this.description, this.changingInterval,
      {this.id, this.aid, this.currentAssigneeId, this.initals});

  void setCurrentAssigneeId(String uid) {
    currentAssigneeId = uid;
  }

  String get currentAssigneeUid {
    return currentAssigneeId;
  }

  void setApartmentId(String id) {
    aid = id;
  }

  String get apartmentId {
    return aid;
  }

  void setId(String value) {
    id = value;
  }

  void setInterval(int interval) {
    changingInterval = interval;
  }

  void setInitals(String value){
    initals = value;
  }

  Map<String, dynamic> getChoreMap() {
    final Map<String, dynamic> chore = {
      'aid': aid,
      'name': name,
      'description': description,
      'changingInterval': changingInterval,
      'currentAssigneeId': currentAssigneeId,
      'initials':initals
    };
    return chore;
  }
}
