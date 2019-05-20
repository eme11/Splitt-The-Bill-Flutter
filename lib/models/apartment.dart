class Apartment {
  final String id;
  final String streetName;
  final String number;
  final String city;
  final String country;

  Apartment(this.id, this.streetName, this.number, this.city, this.country);

  String getAddress() {
    return "str. " +
        streetName +
        "nr. " +
        number +
        ", " +
        this.city +
        " " +
        this.country;
  }
}
