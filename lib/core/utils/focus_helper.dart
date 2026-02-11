class FocusKeys {
  // ---------- LOGIN ----------
  static const String loginRescan = 'login.scan';

  // ---------- TABS ----------
  static const String homeTab = 'home.tab';
  static const String seriesTab = 'series.tab';
  static const String favTab = 'fav.tab';
  static const String searchTab = 'search.tab';
  static const String logoutTab = 'logout.tab';

  // ---------- HOME ----------
  static const String watchNow = 'home.watchNow';
  static const String banner = 'home.banner';
  static const String continueWatching = 'home.continueWatching';
  static const String whatIsNew = 'home.whatIsNew';
  static const String topTen = 'home.topTen';
  static const String characters = 'home.characters';

  // ---------- SERIES ----------
  static const String seriesCategory = 'series.category';
  static const String seriesEpisodes = 'series.episodes';

  // ---------- FAVORITES ----------
  static const String favCategory = 'fav.category';
  static const String favEpisodes = 'fav.episodes';
  static const String favShows = 'fav.shows';
  static const String favCharacters = 'fav.characters';

  // ---------- SEARCH ----------
  static const String searchInput = 'search.input';
  static const String searchKeyboard = 'search.keyboard';
  static const String searchBack = 'search.back';
  static const String searchDeleteHistory = 'search.historyDelete';
  static const String searchHistory = 'search.history';
  static const String searchSuggestions = 'search.suggestions';
  static const String searchResults = 'search.results';

  // ---------- KEYBOARD ----------
  static const String kb = 'kb';
  static const String kbRow = 'kb.row';
  static const String kbDone = 'kb.done';
  static const String kbLang = 'kb.lang';
  static const String kbShift = 'kb.shift';
  static const String kbSpace = 'kb.space';
  static const String kbBack = 'kb.back';
  static const String kbClear = 'kb.clear';

  // ---------- SHOW DETAILS ----------
  static const String detailsWatchButton = 'details.watchButton';
  static const String detailsTab = 'details.tab';
  static const String detailsPlay = 'details.play';
  static const String detailsBack = 'details.back';
  static const String detailsEpisodes = 'details.episodes';
  static const String detailsRelated = 'details.related';
  static const String detailsSuggestions = 'details.suggestions';
  static const String detailsCharacters = 'details.characters';

  // ---------- SHOW PLAYER ----------
  static const String playerBack = 'player.back';
  static const String playerBackward = 'player.backward';
  static const String playerPlayPause = 'player.playPause';
  static const String playerForward = 'player.forward';
  static const String playerProgress = 'player.progress';
  static const String playerSkipIntro = 'player.skipIntro';
  static const String playerNextEpisode = 'player.nextEpisode';
  static const String playerScreen = 'player.screen';

  // ---------- ROW BUTTONS ----------
  static const String rowButtons = 'rowButtons';

// ---------- RATE DIALOG ----------
  static const String rateDialogOk = 'rate.ok';
  static const String rateDialogCancel = 'rate.cancel';


  // ---------- CHARACTERS ----------
  static const String charactersBack = 'characters.back';
  static const String charactersTab = 'characters.tab';
  static const String charactersList = 'characters.list';

}


class FocusId {
  static String tab(String name) => 'tab.$name';

  static String section(String section) => section;

  static String list(String base, int index) =>
      '$base.item.$index';

  static String grid(String base, int row, int col) =>
      '$base.r.$row.c.$col';

 static String favGridEntryKey(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return FocusId.grid(FocusKeys.favEpisodes, 0, 0);
      case 1:
        return FocusId.grid(FocusKeys.favShows, 0, 0);
      case 2:
        return FocusId.grid(FocusKeys.favCharacters, 0, 0);
      default:
        return FocusId.grid(FocusKeys.favEpisodes, 0, 0);
    }
  }
}