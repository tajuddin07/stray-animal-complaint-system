import 'package:firebase_auth/firebase_auth.dart';
import 'package:sac/locator.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/services/authservice.dart';
import 'package:flutter/widgets.dart';
class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();

  Users get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}