class CleainingSupply {
  String id;
  String name;
  String type;
  double price;
  String userId;
  String buyerNickName;
  String aid;

  CleainingSupply(this.id, this.name, this.type, this.price,
      {this.userId, this.aid, this.buyerNickName});

  Map<String, dynamic> getSupplyMap() {
    final Map<String, dynamic> supply = {
      'name': name,
      'type': type,
      'price': price,
      'userId': userId,
      'aid': aid,
      'buyerNickName': buyerNickName
    };
    return supply;
  }

  void setBuyerNickName(String value) {
    buyerNickName = value;
  }

  void setCleaningUID(String uid) {
    userId = uid;
  }

  void setApartmentId(String id) {
    aid = id;
  }

  void setId(String value) {
    id = value;
  }

  String get apartmentId {
    return aid;
  }
}
