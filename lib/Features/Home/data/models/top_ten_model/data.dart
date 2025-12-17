import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';

class Data {
  Data({
    this.topShows,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        topShows: (json['topShows'] as List<dynamic>?)
            ?.map((e) => Details.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  List<Details>? topShows;
}
