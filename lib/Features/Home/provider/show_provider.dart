import 'package:flutter/material.dart';
import 'package:amaan_tv/Features/Home/data/models/show_seasons_model/show_seasons_model.dart';

class ShowProvider extends ChangeNotifier {
  ShowSeasonsModel? seasonsModel;

  // Updated stubs to support named arguments and optional positionals
  void getShowsEpisodesProvide([dynamic arg]) {}
  // getRelatedShowsProvide called with named argument in show_details_tabs? NEED TO CHECK.
  // Assuming it might be called differently. Let's make it flexible or check errors.
  void getRelatedShowsProvide([dynamic arg]) {}

  dynamic get showsEpisodesModel => null;
  dynamic get stateShowsEpisodes => null;
  dynamic get stateRelatedShows => null;
  dynamic get relatedModel => null;
  dynamic get showDetailsModel => null;
  bool get isSuggested => false;

  void functions() {}
}
