import 'package:flutter/material.dart';

class FamilyProvider extends ChangeNotifier {
  dynamic get familyModel => null;
  int get loadingIndex => -1;

  void setLoadingIndex(int? index) {}
  Future<void> shareShow({dynamic model}) async {}
  Future<void> getFamilyModel() async {}
}
