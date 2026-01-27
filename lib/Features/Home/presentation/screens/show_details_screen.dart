import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_state_provider/flutter_state_provider.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/heros_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_details_tabs.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_series_poster/show_detials_poster.dart';
import 'package:amaan_tv/Features/Home/provider/show_provider.dart';
import 'package:amaan_tv/Features/family/provider/family_provider.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/injection/injection_imports.dart' as di;
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/constant.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/app_state_builder.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/Features/Home/provider/show_videos_provider.dart';
import 'package:amaan_tv/core/utils/widget_sliver_extension.dart';
import 'package:amaan_tv/core/utils/api/api_service.dart';

import '../../../../core/widget/app_toast.dart';
import '../../../../core/widget/custom_dialog.dart';
import '../../../subscription/presentation/dialogs/request_subscription_dialog.dart';
import '../../functions.dart';
import '../../provider/time_provider.dart';
import '../widget/no_video_dialog.dart';
import '../widget/repeat_dialog.dart';

class ShowDetailsScreen extends StatefulWidget {
  const ShowDetailsScreen({required this.id, super.key, this.fromMinute});

  final String id;
  final String? fromMinute;

  @override
  State<ShowDetailsScreen> createState() => _ShowDetailsScreenState();
}

class _ShowDetailsScreenState extends State<ShowDetailsScreen> {
  bool get isParent =>
      UserNotifier.instance.userData?.userType.isParent ?? false;

  bool get isChild => UserNotifier.instance.userData?.userType.isChild ?? false;
  ScrollController charactersScrollController = ScrollController();
  int page = 1;

  @override
  void dispose() {
    charactersScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<ShowProvider>(
            create: (context) {
              final showProvider = di.sl<ShowProvider>();
              if (isChild) {
                showProvider.checkIsSuggested(showId: widget.id);
              }
              charactersScrollController.addListener(() {
                if (charactersScrollController.position.pixels >
                    charactersScrollController.position.maxScrollExtent - 200) {
                  page++;
                  showProvider.getCharactersShows(id: widget.id, page: page);
                }
              });

              return showProvider;
            },
          ),
          ChangeNotifierProvider(
            create: (_) =>
                ShowPromosProvider(di.sl<ApiService>())..showId(widget.id),
          ),
          ChangeNotifierProvider(
            create: (_) {
              final familyProvider = di.sl<FamilyProvider>();
              if (isParent) familyProvider.getFamilyModel();
              return familyProvider;
            },
          ),
        ],
        child: AppStateBuilder<ShowProvider, Details>(
          initState: (provider) => provider.getAllData(widget.id),
          state: (provider) => provider.stateShowDetails,
          selector: (provider) => provider.showDetailsModel,
          builder: (context, showDetailsModel, child) {
            final provider = context.read<ShowProvider>();
            final isSeries = showDetailsModel.type == ShowDetailsType.series;
            final tabs = [
              if (isSeries) Tab(text: AppLocalization.strings.episodes),
              Tab(text: AppLocalization.strings.related),
              Tab(
                text: AppLocalization.strings.theSuggestions,
              ), // Using theSuggestions as per mobile
              Tab(text: AppLocalization.strings.more),
            ];
            return DefaultTabController(
              length: tabs.length,
              child: CustomScrollView(
                slivers: [
                  AppStateBuilder<ShowProvider, AppState>(
                    initState: (provider) => provider.getAllData(widget.id),
                    state: (provider) => provider.stateShowDetails,
                    selector: (provider) => provider.stateGenerateVideoUrl,
                    builder: (context, state, child) => ShowSeriesPoster(
                      model: showDetailsModel,
                      refresh: () => provider.getAllData(widget.id),
                      isLoading:
                          provider.stateGenerateVideoUrl == AppState.loading,
                      onTapShow: () {
                        final isAllowed = checkIfVideoAllowed(
                          isFree: showDetailsModel.isFree,
                          isGuest: showDetailsModel.isGuest,
                          context: context,
                        );

                        if (isAllowed != null) {
                          AppToast.show(isAllowed);
                          return;
                        } else if (!context
                            .read<TimeProvider>()
                            .isValidToContinue) {
                          AppToast.show(
                            AppLocalization.strings.watchingNotAllowed,
                          );
                          return;
                        } else if (provider.showVideo?.presignedUrl != null) {
                          if (showDetailsModel.isRepeat) {
                            showDialog<int>(
                              context: context,
                              builder: (context) {
                                return CustomDialog(content: RepeatDialog());
                              },
                            ).then((value) {
                              if (value != null)
                                context.pushNamed(
                                  AppRoutes.showPlayer.routeName,
                                  extra: {
                                    'show': showDetailsModel,
                                    'url': provider.showVideo!.presignedUrl!,
                                    'videoId': provider.videoId!,
                                    'episodesModel':
                                        provider.showsEpisodesModel?.data,
                                    'fromMinute': widget.fromMinute,
                                    'repeatTimes': value,
                                  },
                                );
                            });
                          } else {
                            context.pushNamed(
                              AppRoutes.showPlayer.routeName,
                              extra: {
                                'show': showDetailsModel,
                                'url': provider.showVideo!.presignedUrl!,
                                'videoId': provider.videoId!,
                                'episodesModel':
                                    provider.showsEpisodesModel?.data,
                                'fromMinute': widget.fromMinute,
                              },
                            );
                          }
                        } else if (provider.videoId == null) {
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return CustomDialog(content: NoVideoDialog());
                            },
                          );
                          return;
                        } else {
                          RequestSubscriptionsDialog.show(context);
                        }
                      },
                    ),
                  ).sliver,
                  24.verticalSpace.sliver,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constant.paddingLeftRight,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      // decoration: containerDecoration(context), // Check if exists
                      child: Text(
                        showDetailsModel.description!,
                        textAlign: TextAlign.center,
                        style: AppTextStylesNew.style12BoldAlmarai.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ).sliver,
                  Selector<ShowProvider,
                      StateProvider<CharactersModel, String>>(
                    selector: (context, provider) =>
                        provider.stateCharactersShows,
                    builder: (context, stateCharacters, child) {
                      return provider.stateCharactersShows.when<Widget>(
                          AppCircleProgressHelper.new,
                          (error) => SizedBox.shrink(), (
                        data,
                      ) {
                        final charactersModel = data;
                        return provider.charactersModelShows?.data.isEmpty ??
                                true
                            ? SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  16.verticalSpace,
                                  Padding(
                                    padding: const EdgeInsetsDirectional.only(
                                      start: Constant.paddingLeftRight,
                                    ),
                                    child: Text(
                                      AppLocalization.strings.characters,
                                      style:
                                          AppTextStylesNew.style16BoldAlmarai,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: HerosWidget(
                                      characters: charactersModel.data,
                                      charactersScrollController:
                                          charactersScrollController,
                                    ),
                                  ),
                                ],
                              );
                      });
                    },
                  ).sliver,
                  24.verticalSpace.sliver,
                  PinnedHeaderSliver(child: ShowDetailsTabs(tabs: tabs)),
                  ShowDetailsTabBarView(showId: widget.id, isSeries: isSeries),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
