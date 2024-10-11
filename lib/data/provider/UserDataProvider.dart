import 'package:app_flutter_miban4/data/model/userData/user.dart';
import 'package:flutter/foundation.dart';


class UserDataProvider with ChangeNotifier {
  UserData? _userData;

  UserData? get userData => _userData;

  void setUserData(UserData userData) {
    _userData = userData;
    notifyListeners();
  }
}
