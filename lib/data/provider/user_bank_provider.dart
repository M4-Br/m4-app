import 'package:app_flutter_miban4/data/model/userData/bank.dart';
import 'package:flutter/foundation.dart';

class UserDataProvider with ChangeNotifier {
  BankUser? _bankUser;

  BankUser? get userData => _bankUser;

  void setUserData(BankUser bankUser) {
    _bankUser = userData;
    notifyListeners();
  }
}