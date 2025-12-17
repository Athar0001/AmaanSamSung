import 'package:flutter/foundation.dart';
import 'package:amaan_tv/core/models/content_type.dart';

final _favorites = Expando<Map<String, WeakReference<ValueNotifier<bool>>>>();

abstract class FavoriteModel {

  FavoriteModel({
    required this.id,
    required this.contentType,
    bool? isFavorite,
  }) : isFavorite = isFavoriteFactory(isFavorite ?? false, contentType, id);
  final ContentType contentType;
  final String id;
  final ValueNotifier<bool> isFavorite;

  static ValueNotifier<bool> isFavoriteFactory(
    bool isFavorite,
    ContentType type,
    String id,
  ) {
    late final notifierRef = WeakReference(ValueNotifier(isFavorite));
    return (_favorites[type] ??= {}).update(
      id,
      (ref) {
        if (ref.target == null) return notifierRef;
        return ref..target?.value = isFavorite;
      },
      ifAbsent: () => notifierRef,
    ).target!;
  }
}
