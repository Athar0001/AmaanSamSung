import 'package:amaan_tv/core/utils/enum.dart';

mixin PaginationMixin<T> {
  int currentPage = 1;
  bool isLoadMore = false;
  Future<void> getData({int? pageNumber, Function(List<T>)? onSuccess}) async {}

  int get totalLength => 10;
  dynamic get pagination => null;

  AppState get state => AppState.init;

  int get pageSize => 10;

  List<T> get allItems => [];

  void loadPageForIndex(int index, {Function(List<T>)? onSuccess}) {}
  void onSuccess(List<T> items) {}
}
