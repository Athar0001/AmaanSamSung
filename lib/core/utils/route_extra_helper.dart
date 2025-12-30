import 'dart:convert';

import 'package:flutter/material.dart';

/// Comprehensive utility functions for handling extra data in routes
/// These functions provide safe methods to extract and access data passed through
/// the extra parameter in GoRouter navigation.
abstract class RouteExtraHelper {
  /// Private constructor to prevent instantiation
  RouteExtraHelper._();

  /// Safely extract Map from extra data
  static Map<String, dynamic>? extractMap(Object? extra) {
    if (extra == null) return null;
    if (extra is Map<String, dynamic>) return extra;
    if (extra is Map) return Map<String, dynamic>.from(extra);

    // Try to decode if it's a JSON string
    if (extra is String) {
      try {
        final decoded = jsonDecode(extra);
        if (decoded is Map<String, dynamic>) return decoded;
      } catch (e) {
        // If JSON decoding fails, return null
        return null;
      }
    }

    return null;
  }

  /// Safely get string value with default
  static String getString(
    Object? extra,
    String key, [
    String defaultValue = '',
  ]) {
    final map = extractMap(extra);
    if (map == null) return defaultValue;
    try {
      return (map[key] as String?) ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely get nullable string value
  static String? getNullableString(Object? extra, String key) {
    final map = extractMap(extra);
    if (map == null) return null;
    try {
      return map[key] as String?;
    } catch (_) {
      return null;
    }
  }

  /// Safely get int value with default
  static int getInt(Object? extra, String key, [int defaultValue = 0]) {
    final map = extractMap(extra);
    if (map == null) return defaultValue;
    try {
      return (map[key] as int?) ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely get nullable int value
  static int? getNullableInt(Object? extra, String key) {
    final map = extractMap(extra);
    if (map == null) return null;
    try {
      return map[key] as int?;
    } catch (_) {
      return null;
    }
  }

  /// Safely get bool value with default
  static bool getBool(Object? extra, String key, [bool defaultValue = false]) {
    final map = extractMap(extra);
    if (map == null) return defaultValue;
    try {
      return (map[key] as bool?) ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely get nullable bool value
  static bool? getNullableBool(Object? extra, String key) {
    final map = extractMap(extra);
    if (map == null) return null;
    try {
      return map[key] as bool?;
    } catch (_) {
      return null;
    }
  }

  /// Safely get double value with default
  static double getDouble(
    Object? extra,
    String key, [
    double defaultValue = 0.0,
  ]) {
    final map = extractMap(extra);
    if (map == null) return defaultValue;
    try {
      return (map[key] as double?) ?? defaultValue;
    } catch (_) {
      return defaultValue;
    }
  }

  /// Safely get nullable double value
  static double? getNullableDouble(Object? extra, String key) {
    final map = extractMap(extra);
    if (map == null) return null;
    try {
      return map[key] as double?;
    } catch (_) {
      return null;
    }
  }

  /// Safely get any value with type casting
  static T? getValue<T>(Object? extra, String key) {
    final map = extractMap(extra);
    if (map == null) return null;
    try {
      return map[key] as T?;
    } catch (_) {
      return null;
    }
  }

  /// Safely get complex objects that might not be JSON serializable
  /// Use this for objects like AuthProvider, Controllers, etc.
  static T? getComplexValue<T>(Object? extra, String key) {
    if (extra == null) return null;

    // Try to extract from Map first
    final map = extractMap(extra);
    if (map != null) {
      try {
        return map[key] as T?;
      } catch (_) {
        return null;
      }
    }

    // If extra is not a map, it might be the object itself
    if (extra is T) {
      return extra as T;
    }

    return null;
  }

  /// Safely get provider instance that extends ChangeNotifier
  /// Use this for providers like AuthProvider, SubscriptionProvider, etc.
  static T? getProvider<T extends ChangeNotifier>(Object? extra, String key) {
    return getComplexValue<T>(extra, key);
  }

  /// Check if extra contains a specific key
  static bool containsKey(Object? extra, String key) {
    final map = extractMap(extra);
    return map?.containsKey(key) ?? false;
  }

  /// Get all keys from extra data
  static List<String> getKeys(Object? extra) {
    final map = extractMap(extra);
    return map?.keys.toList() ?? [];
  }

  /// Check if extra is empty
  static bool isEmpty(Object? extra) {
    final map = extractMap(extra);
    return map?.isEmpty ?? true;
  }

  /// Get the length of extra data
  static int length(Object? extra) {
    final map = extractMap(extra);
    return map?.length ?? 0;
  }
}
