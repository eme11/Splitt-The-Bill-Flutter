class CleainingSupply{
  String name;
  String type;
  double price;
  String userId;

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
}