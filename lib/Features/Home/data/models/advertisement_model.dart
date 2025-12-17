import 'dart:convert';

class AdvertisementModel {
  final String imageUrl;
  final DateTime? startDate;
  final DateTime? endDate;

  AdvertisementModel({required this.imageUrl, this.startDate, this.endDate});

  factory AdvertisementModel.fromJson(Map<String, dynamic> json) {
    // Parse Meta string if it exists
    Map<String, dynamic> meta = {};
    if (json['data'] != null && json['data']['Meta'] != null) {
      try {
        meta = jsonDecode(json['data']['Meta']);
      } catch (e) {
        print('Error parsing Meta json: $e');
      }
    }

    // Get dates from Meta
    DateTime? start;
    if (meta['StartDate'] != null) {
      start = DateTime.tryParse(meta['StartDate']);
    }
    // Fallback to sentTime if StartDate is null
    if (start == null && json['sentTime'] != null) {
      start = DateTime.fromMillisecondsSinceEpoch(json['sentTime']);
    }

    DateTime? end;
    if (meta['EndDate'] != null) {
      end = DateTime.tryParse(meta['EndDate']);
    }
    // Fallback to start + 1 day if EndDate is null
    if (end == null && start != null) {
      end = start.add(const Duration(days: 1));
    }

    // Image URL can be in data or in Meta
    String imgUrl = '';
    if (json['data'] != null && json['data']['ImageUrl'] != null) {
      imgUrl = json['data']['ImageUrl'];
    } else if (meta['ImageUrl'] != null) {
      imgUrl = meta['ImageUrl'];
    }

    return AdvertisementModel(imageUrl: imgUrl, startDate: start, endDate: end);
  }

  Map<String, dynamic> toJson() {
    return {
      'imageUrl': imageUrl,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    };
  }

  factory AdvertisementModel.fromStorageJson(Map<String, dynamic> json) {
    return AdvertisementModel(
      imageUrl: json['imageUrl'],
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'])
          : null,
      endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
    );
  }
}
