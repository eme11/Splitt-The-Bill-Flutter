class CleainingSupply{
  String name;
  String type;
  double price;
  String userId;
  String aid;

  CleainingSupply(this.name, this.type, this.price, this.userId);

  Map<String, dynamic> getSupplyMap(){
    final Map<String, dynamic> supply = {
      'name':name,
      'type': type,
      'price': price,
      'userId':userId
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