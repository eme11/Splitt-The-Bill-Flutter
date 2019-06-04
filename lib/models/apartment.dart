import 'package:flutter/material.dart';

class Apartment {
  String id;
  String streetName;
  int number;
  String city;
  String country;

  Apartment(this.id, this.streetName, this.number, this.city, this.country);

  Apartment.clone(Apartment apartment)
      : this(apartment.id, apartment.streetName, apartment.number,
            apartment.city, apartment.country);

  String getAddress() {
    return "str. " +
        streetName +
        " nr. " +
        number.toString() +
        ", " +
        this.city +
        " " +
        this.country;
  }

  void setId(String value) {
    id = value;
  }

  Map<String, dynamic> getApartmentMap() {
    Map<String, dynamic> _map = {
      'street': streetName,
      'number': number,
      'city': city,
      'country': country,
    };
    return _map;
  }
}
