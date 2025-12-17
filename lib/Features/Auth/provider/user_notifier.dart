import 'package:flutter/foundation.dart';
import 'package:amaan_tv/Features/Auth/data/models/login_model.dart';

class UserNotifier with ChangeNotifier {
  static final UserNotifier instance = UserNotifier();

  UserData? _userData;

  UserNotifier() {
    // Initialize with dummy data
    _userData = UserData(id: 1, name: "Amaan TV User");
  }

  UserData? get userData => _userData;
  bool get isLogin => _userData != null;

  Future<void> refreshUser() async {
    // No-op
  }

  String? genderOfChild;
  void selectChild(String label) {
    genderOfChild = label;
    notifyListeners();
  }
}
