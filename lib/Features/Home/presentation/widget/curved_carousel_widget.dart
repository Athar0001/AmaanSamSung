import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Auth/data/models/login_model.dart';
import 'package:amaan_tv/Features/Auth/provider/user_notifier.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/flavors.dart';
import 'package:amaan_tv/gen/assets.gen.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';

import 'package:amaan_tv/Features/reels/presentation/reels_screen.dart';
import 'package:amaan_tv/Features/tasks/child/presentation/screens/tasks_screen.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/app_navigation.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/curved_wheel_list.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CurvedCarouselWidget extends StatefulWidget {
  const CurvedCarouselWidget({super.key});

  @override
  State<CurvedCarouselWidget> createState() => _CurvedCarouselWidgetState();
}

class _CurvedCarouselWidgetState extends State<CurvedCarouselWidget> {
  @override
  Widget build(BuildContext context) {
    final showTasks =
        UserNotifier.instance.userData?.userType == UserType.child &&
            AppFlavor.flavor.showInProd;
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        const isLive = false;
        if (provider.stateHomeReels == AppState.error) {
          // Show an error message
          return Text("Error", style: AppTextStylesNew.style16BoldAlmarai);
        }

        if (provider.reelsHomeModel == null ||
            provider.reelsHomeModel?.data?.isEmpty == true) {
          // Show a message for empty data
          return Text(
            'No reels available',
            style: AppTextStylesNew.style16BoldAlmarai,
            textAlign: TextAlign.center,
          );
        }

        // Show the carousel when data is successfully loaded
        return Skeletonizer(
          effect: PulseEffect(),
          enabled: provider.stateHomeReels == AppState.loading,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: CurvedWheelList(
              height: 190.r,
              curveRadius: 550.r,
              itemSize: 100.r,
              itemCount: provider.reelsHomeModel!.data!.length +
                  (isLive ? 1 : 0) +
                  (showTasks ? 1 : 0),
              itemBuilder: (context, index) {
                if (showTasks && index == 1) {
                  return _TasksWidget();
                }
                if (showTasks && index > 1) {
                  index -= 1;
                }
                return _ReelWidget(index: index);
              },
            ),
          ),
        );
      },
    );
  }
}

class _TasksWidget extends StatelessWidget {
  const _TasksWidget();

  @override
  Widget build(BuildContext context) {
    return TvClickButton(
      onTap: () {
        AppNavigation.navigationPush(context, screen: TasksScreen());
      },
      child: Column(
        // alignment: AlignmentDirectional.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30.h),
            child: Container(
              height: 70.r,
              width: 70.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColorsNew.amber3,
              ),
              child: Padding(
                padding: EdgeInsets.all(3.r),
                child: Container(
                  height: 63.r,
                  width: 63.r,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1.r,
                    ),
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: Assets.images.tasks.image(
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          4.verticalSpace,
          Text(
            AppLocalization.strings.myTasks,
            style: AppTextStylesNew.style12BoldAlmarai.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReelWidget extends StatelessWidget {
  const _ReelWidget({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return TvClickButton(
      onTap: () {
        final reelsData = provider.reelsHomeModel!.data!;
        final start = reelsData.getRange(0, index);
        final end = reelsData.getRange(index + 1, reelsData.length);
        final reels = [reelsData[index], ...end, ...start];
        AppNavigation.navigationPush(
          context,
          screen: ReelsScreen(reels: reels),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(top: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 84.r,
              width: 84.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColorsNew.amber3, AppColorsNew.amber2],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(3.r),
                child: Container(
                  height: 65.r,
                  width: 65.r,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 5.r,
                    ),
                    shape: BoxShape.circle,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  child: ClipOval(
                    child: CachedNetworkImageHelper(
                      width: double.infinity,
                      height: double.infinity,
                      imageUrl: provider.reelsHomeModel?.data?[index]
                              .thumbnailImage?.url ??
                          '',
                    ),
                  ),
                ),
              ),
            ),
            5.verticalSpace,
            // Text(
            //   provider.reelsHomeModel?.data?[index].title?.split(" ").first ??
            //       '',
            //   style: AppTextStylesNew.style12BoldAlmarai
            //       .copyWith(fontWeight: FontWeight.w400, fontSize: 12.r),
            // ),
          ],
        ),
      ),
    );
  }
}
