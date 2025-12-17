import 'package:amaan_tv/flavors.dart';

mixin EndPoint {
  //TODO: add from flavor
  static final String strip = 'https://api.stripe.com/v1/payment_intents';
  static final String baseImageUrl = AppFlavor.data.baseImageUrl;
  static final String baseUrl = AppFlavor.data.baseUrl;

  ////////////---tasks api (children tasks)---////////////////
  static final String taskPath = 'task/api/';
  static final String taskLookups = '$baseUrl/${taskPath}TaskLookups';
  static String parentChildrenTasks =
      '$baseUrl/${taskPath}ChildTasks';
  // Create child task (POST uses same path)
  static String createChildTask = '$baseUrl/${taskPath}ChildTasks';
  // Task icons/attachments
  static String taskIcons = '$baseUrl/${taskPath}TaskIcons';
  static String childTasksByChild(String childId) =>
      '$baseUrl/${taskPath}ChildTasks/$childId';
  // Single child task by id (PUT/DELETE)
  static String childTaskById(String taskId) =>
      '$baseUrl/${taskPath}ChildTasks/$taskId';

  static final String urlPath1 = 'identity/api/';
  static final String urlPath2 = 'content/api/';
  static final String subscriptionPath = 'subscription/api/';
  static final String getProfile = '$baseUrl/identity/api/Users/GetProfile';
  static final String login = 'login';
  static final String googleLogin = '$baseUrl/${urlPath1}Account/GoogleLogin';
  static final String appleLogin = '$baseUrl/${urlPath1}Account/AppleLogin';
  static final String loginURL = '$baseUrl/${urlPath1}Account/$login';
  static final String guestLogin = '$baseUrl/${urlPath1}Account/GuestLogin';
  static final String refreshTokenURL = '${urlPath1}Account/RefreshToken';
  static final String xLogin = '${urlPath1}Account/xLogin';
  static final String registerURL =
      '$baseUrl/${urlPath1}Account/registerparent'; //add
  static final String secParentUrl =
      '$baseUrl/${urlPath1}Account/AddParentAccount'; //add
  //register child
  static final String addChildURL =
      '$baseUrl/${urlPath1}Account/registerchild'; //add
  static final String editChildURL =
      '$baseUrl/${urlPath1}Users/UpdateChildProfile';
  static final String getQuestions =
      '$baseUrl/${urlPath1}personality/categories';
  static final String getQuestionsAnswered =
      '$baseUrl/${urlPath1}personality/ChildAnswers';
  static final String submitAnswers =
      '$baseUrl/${urlPath1}personality/childanswers/bulkadd';
  static final String updateAnswers =
      '$baseUrl/${urlPath1}personality/childanswers/BulkUpdate';

  // set pin
  static final String setPin = '$baseUrl/${urlPath1}Users/SetPinCode';
  static final String verifyPinCode = '$baseUrl/${urlPath1}Users/VerifyPinCode';
  static final String requestEmailVerifOTP =
      '$baseUrl/${urlPath1}Account/RequestEmailVerifOTP';
  static final String requestPhoneVerifOTP =
      '$baseUrl/${urlPath1}Account/RequestPhoneVerifOTP';
  static final String verifyEmailOTP =
      '$baseUrl/${urlPath1}Account/VerifyEmailOTP';
  static final String requestEmailResetPassOTP =
      '$baseUrl/${urlPath1}Account/RequestEmailResetPassOTP';
  static final String requestPhoneResetPassOTP =
      '$baseUrl/${urlPath1}Account/RequestPhoneResetPassOTP';
  static final String resetPassWithEmailOTP =
      '$baseUrl/${urlPath1}Account/ResetPassWithEmailOTP';
  static final String resetPassWithPhoneOTP =
      '$baseUrl/${urlPath1}Account/ResetPassWithPhoneOTP';
  static final String logout = '$baseUrl/${urlPath1}Account/logout';
  static final String deleteAccount = '$baseUrl/${urlPath1}Account';

  // static final String getRangeAge = "${urlPath2}lookups/AgeRanges";
  static final String getFamily =
      '$baseUrl/${urlPath1}Users/GetRelatedAccounts';
  static final String getTimeMange = '$baseUrl/${urlPath1}UserTimes';
  static final String setTimeMange = '$baseUrl/${urlPath1}UserTimes';
  static final String getDailyTime = '$baseUrl/${urlPath1}UserTimes/DailyUsage';
  static final String setTimeLog = '$setTimeMange/Log';
  static final String continueWatching =
      '$baseUrl/notification/api/UserRequests';

  // Plans & Payment
  static final String getUserSubscriptionInfo =
      '$baseUrl/${subscriptionPath}UserSubscriptions/GetActiveUserSubscription/';
  static final String getPlans = '$baseUrl/subscription/api/Plans/public';
  static final String promoCodeCheck =
      '$baseUrl/subscription/api/PromoCodes/CheckPromoCode';
  static final String userFavoriteEpisodes =
      "$baseUrl/$urlPath2${'UserFavoriteEpisodes'}";
  static final String userFavoriteShows =
      "$baseUrl/$urlPath2${'UserFavoriteShows'}";
  static final String userFavoriteCharacters =
      "$baseUrl/$urlPath2${'UserFavoriteCharacters'}";
  static final String createIdUserSubscriptions =
      "$baseUrl/subscription/api/UserSubscriptions/";
  static final String upgradeSubscriptionNew =
      "$baseUrl/subscription/api/UserSubscriptions/UpgradeSubscription_New/";
  static final String createPayment =
      '$baseUrl/subscription/api/Payments/CreatePayment';
  static final String successPayment =
      '$baseUrl/subscription/api/Payments/SuccessPayment';
  static final String successApplePayment =
      '$baseUrl/subscription/api/Payments/AppleSuccessPayment';
  static final String cancelSubscription =
      '$baseUrl/subscription/api/Payments/MyFatoorahCancel';
  static final String loginChild =
      '$baseUrl/${urlPath1}Account/SwitchToChildProfile';
  static final String loginParent =
      '$baseUrl/${urlPath1}Account/SwitchToParentProfile';

  ////////////---home api---///////////////

  static final String getBanner =
      '$baseUrl/content/api/ShowBanners/GetHomeShowBanner';
  static final String getAllReels = '$baseUrl/content/api/Shows/GetAllReels';
  static final String getLatestReels =
      '$baseUrl/content/api/Shows/GetLatestReels';
  static final String getCharacters = '$baseUrl/content/api/Characters';
  static final String getCharactersBg =
      '$baseUrl/content/api/Attachments/GetCharactersBg';
  static final String getHomeCharacters =
      '$baseUrl/content/api/Characters/GetHomeCharacters';
  static final String getShowDetailsCharacters =
      '$baseUrl/content/api/Characters/GetShowCharacters';
  static final String getCategories =
      '$baseUrl/content/api/lookups/Categories/GetHomeCategories';

  static final String getModules =
      // "$baseUrl/content/api/lookups/ModuleAttachments";
      '$baseUrl/content/api/lookups/ContentModules';

  static final String getParentCategories =
      '$baseUrl/content/api/lookups/Categories/GetParentCategories';
  static final String getSubCategories =
      '$baseUrl/content/api/lookups/Categories/GetHomeChildCategories';
  static final String getShows = '$baseUrl/content/api/Shows';
  static final String getTop = '$baseUrl/content/api/Shows/GetTopShows';
  static final String getSeasons = '$baseUrl/content/api/Shows/ShowSeasons';
  static final String getInCompletedShows =
      '$baseUrl/content/api/Shows/GetInCompletedShows';
  static final String getLatest = '$baseUrl/content/api/Shows/GetLatest';
  static final String getLatestPagination =
      '$baseUrl/content/api/Shows/GetLatestPagination';
  static final String mostListened = '$baseUrl/analytics/api/Shows';
  static final String getShowEpisodes =
      '$baseUrl/content/api/Episodes/GetShowEpisodes';
  static final String getShowDetails =
      '$baseUrl/content/api/QuizShows/Getshowdetails';
  static final String getEpisodeDetails =
      '$baseUrl/content/api/QuizShows/Getepisodedetails';
  static final String getRelated = '$baseUrl/content/api/Shows/GetRelated';
  static final String generateDownloadUrl = 'GenerateDownloadUrl';
  static final String generateAudioDownloadUrl = 'GenerateAudioDownloadUrl';
  static final String getShowsVideo =
      '$baseUrl/content/api/Shows/$generateDownloadUrl';
  static final String getAudioVideo =
      '$baseUrl/content/api/Shows/$generateAudioDownloadUrl';
  static final String sendShareShow = '$baseUrl/identity/api/ParentShareShows';
  static final String isRecomendedByParent =
      '$baseUrl/identity/api/ParentShareShows/IsRecomendedByParent';

  static final String getShowVideoByVideoType =
      '$baseUrl/content/api/Shows/GetShowVideoByVideoType';

  static final String getEpisodesVideo =
      '$baseUrl/content/api/Episodes/$generateDownloadUrl';
  static final String sendVideoTransaction =
      '$baseUrl/analytics/api/VideoTransaction';
  static final String search = '$baseUrl/${urlPath2}Search';
  static final String suggestedSearch =
      '$baseUrl/${urlPath2}Shows/GetPreferredShows';
  static final String recentSearch = '$baseUrl/${urlPath1}RecentSearchs';
  static final String deleteRecentSearch =
      '$baseUrl/${urlPath1}RecentSearchs/Empty';
  static final String updateParentProfile =
      '$baseUrl/${urlPath1}Users/UpdateParentProfile';
  static final String getParentProfile = '$baseUrl/${urlPath1}Users/GetParent';
  static final String getConnectedDevices =
      '$baseUrl/identity/api/Users/GetConnectedDevices';

  static String removeDevice(String userDeviceId) =>
      '$baseUrl/identity/api/Users/RemoveDevice/$userDeviceId';

  static final String review = '$baseUrl/content/api/Reviews';

  ////////////---notification api---////////////////

  static final String getNotifications =
      '$baseUrl/notification/api/UserNotifications';
  static final String respondChildRequest =
      '$baseUrl/notification/api/UserRequests/Respond';

  ////////////---quiz api---////////////////
  static final String childExam = '$baseUrl/quiz/api/ChildExams';
  static final String childAnalysisQuiz =
      '$baseUrl/quiz/api/ChildExams/MyChild';
  static final String getQuizExam = '$baseUrl/quiz/api/ChildExams';
  static final String answerQuestion =
      '$baseUrl/quiz/api/ChildExams/AnswerQuestion';
  static final String getExamScore = '$baseUrl/quiz/api/ChildExams/ExamScore';
  static final String retakeExam = '$baseUrl/quiz/api/ChildExams/Retake';

  static String getTopTen(String? examId) {
    return examId != null
        ? '$baseUrl/identity/api/UserExam/TopTen?examId=$examId'
        : '$baseUrl/quiz/api/ChildExams/TopTenScore';
  }

  ////////////---analytics api---////////////////
  static final String getUsageTime =
      '$baseUrl/${urlPath1}UserTimes/GetChildUsageTime';

  ////////////---reels api---////////////////
  static final String getCommentReel = '$baseUrl/${urlPath1}UserReelComments';
  static final String likeReel = '$baseUrl/identity/api/UserReelLikes';
  static final String makeReelComments =
      '$baseUrl/identity/api/UserReelComments';
  static final String likeReelComment =
      '$baseUrl/identity/api/UserReelCommentLikes';
  static final String validateVideoTime =
      '$baseUrl/identity/api/UserTimes/ValidateAllowingTime';

  ////////////---radio api---////////////////
  static final String Playlists = '$baseUrl/content/api/Playlists';
  static final String playlistAudioAnalysis =
      '$Playlists/GetUserPlaylistAudioAnalysis';
  static final String PlaylistsWithShow =
      '$baseUrl/content/api/Playlists/WithShowId';
  static final String getPlaylistShows = '$baseUrl/content/api/Playlists';
  static final String addPlaylistShows = '$baseUrl/content/api/PlaylistShows';
  static final String orderPlaylist = '$addPlaylistShows/OrderPlaylist';
  static final String AddShowToPlaylists =
      '$baseUrl/content/api/PlaylistShows/AddShowToPlaylists';

  static final String station = 's57f27ad3c';
  static final String radioLive =
      'https://public.radio.co/stations/$station/status';
  static final String scheduleRadio =
      'https://public.radio.co/stations/$station/embed/schedule';

  static final String radioStream = 'https://s4.radio.co/$station/listen';

  //////////////////// notification api ////////////////////
  static final String addTicket =
      '$baseUrl/notification/api/UserNotifications/ContactUsEmail';

  //////////////////// ticketing api ////////////////////
  static final String uploadAttachment = '$baseUrl/ticketing/api/Attachments';
  static final String addTicketNew = '$baseUrl/ticketing/api/Tickets';
  static final String getMyTickets =
      '$baseUrl/ticketing/api/Tickets/getMyTickets';
  static final String getTicketDetails = '$baseUrl/ticketing/api/Tickets';
  static final String replyToTicket = '$baseUrl/ticketing/api/Tickets/reply';

  //https://public.radio.co/api/v2/s57f27ad3c
  //{
  // "data": {
  // "name": "Amaan",
  // "logo": "https://images.radio.co/station_logos/s57f27ad3c.20250306093509.png",
  // "streaming_links": [
  // {
  // "url": "https://s4.radio.co/s57f27ad3c/listen"
  // },
  // {
  // "url": "https://s4.radio.co/s57f27ad3c/low"
  // }
  // ]
  // }
  // }
}
