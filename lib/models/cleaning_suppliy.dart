class CleainingSupply{
  String id;
  String name;
  String type;
  double price;
  String userId;
  String aid;

  CleainingSupply(this.id, this.name, this.type, this.price, {this.userId, this.aid});

  Map<String, dynamic> getSupplyMap(){
    final Map<String, dynamic> supply = {
      'name':name,
      'type': type,
      'price': price,
      'userId':userId,
      'aid':aid
    };
    return supply;
  }

  void setCleaningUID(String uid){
    userId = uid;
  }

  void setApartmentId(String id){
    aid = id;
  }

  String get apartmentId{
    return aid;
  }

}