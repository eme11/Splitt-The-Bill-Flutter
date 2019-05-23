import 'package:scoped_model/scoped_model.dart';

import '../models/user.dart';

mixin UserModel on Model{
  User _currentUser;

  User get currentUser{
    return _currentUser;
  }

}