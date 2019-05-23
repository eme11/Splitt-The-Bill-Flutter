import 'package:scoped_model/scoped_model.dart';

import '../models/apartment.dart';

mixin ApartmentModel on Model{
  Apartment _currentApartment;

  Apartment get currentApartmnet{
    return _currentApartment;
  }

}