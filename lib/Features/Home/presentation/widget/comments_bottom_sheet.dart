import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/comment_parm_model.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/seasons_bottom_sheet.dart';
import 'package:amaan_tv/Features/Home/provider/reel_provider.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/asset_manager.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/utils/strings.dart';
import 'package:amaan_tv/core/widget/icon_widget.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

void showCommentsBottomSheet(BuildContext context, ReelProvider reelProvider,
    String reelId, VoidCallback onCommentClick) {
  final commentController = TextEditingController();

  showModalBottomSheet(
    // backgroundColor: AppColorsNew.scaffoldDarkColor,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
          initialChildSize: 0.6,
          maxChildSize: 0.75,
          minChildSize: 0.4,
          expand: false,
          builder: (_, scrollController) {
            return DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: ChangeNotifierProvider.value(
                value: reelProvider,
                child: Consumer<ReelProvider>(
                    builder: (context, reelProvider, child) => Skeletonizer(
                          enabled: reelProvider.stateCommentsReels ==
                              AppState.loading,
                          child: Column(
                            children: [
                              TopIndicator(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  AppLocalization.strings.comments,
                                  style: AppTextStylesNew.style16BoldAlmarai,
                                ),
                              ),
                              Expanded(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount:
                                      reelProvider.commentsReelsModel?.length ??
                                          0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.r,
                                        vertical: 8.r,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          AvatarPersonImageWidget(
                                            imageUrl: reelProvider
                                                    .commentsReelsModel?[index]
                                                    .user
                                                    ?.profilePicture
                                                    ?.url ??
                                                AppStrings.avatar,
                                            height: 40.r,
                                            width: 40.r,
                                          ),
                                          SizedBox(width: 12.r),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  reelProvider
                                                          .commentsReelsModel?[
                                                              index]
                                                          .user
                                                          ?.fullName ??
                                                      'ريم علي',
                                                  style: AppTextStylesNew
                                                      .style14RegularAlmarai
                                                      .copyWith(
                                                          color: AppColorsNew
                                                              .darkGrey1),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  reelProvider
                                                          .commentsReelsModel?[
                                                              index]
                                                          .comment ??
                                                      'أحببت الحلقة كثيراً، كانت مثيرة ومشوقة جداً',
                                                  style: AppTextStylesNew
                                                      .style16BoldAlmarai
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          GestureDetector(
                                            onTap: () {
                                              reelProvider.likeReelComment(
                                                  reelProvider
                                                      .commentsReelsModel![
                                                          index]
                                                      .id!);
                                              reelProvider
                                                  .toggleLikeState(index);
                                            },
                                            child: IconWidget(
                                              path: reelProvider
                                                      .commentsReelsModel![
                                                          index]
                                                      .isLiked
                                                  ? Assets.imagesTrueHeart
                                                  : Assets.imagesFalseHeart,
                                              iconColor: reelProvider
                                                      .commentsReelsModel![
                                                          index]
                                                      .isLiked
                                                  ? AppColorsNew.primary
                                                  : AppColorsNew.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Divider(
                                thickness: 1,
                                color: AppColorsNew.darkGrey1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 16.w,
                                  right: 16.w,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom +
                                          8.r,
                                  top: 8.h,
                                ),
                                child: Row(
                                  children: [
                                    AvatarPersonImageWidget(
                                      imageUrl: AppStrings.avatar,
                                      height: 40.h,
                                      width: 40.w,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: TextField(
                                        controller: commentController,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                          hintText: AppLocalization
                                              .strings.addYourComment,
                                          hintStyle: AppTextStylesNew
                                              .style14RegularAlmarai
                                              .copyWith(
                                                  color:
                                                      AppColorsNew.darkGrey1),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    IconButton(
                                      icon: Icon(Icons.send,
                                          color: AppColorsNew.primary),
                                      onPressed: () {
                                        final newComment =
                                            commentController.text.trim();

                                        if (newComment.isNotEmpty) {
                                          reelProvider.makeCommentsReels(
                                              model: CommentParmModel(
                                            comment: newComment,
                                            reelId: reelId,
                                          ));
                                          onCommentClick();
                                          commentController.clear();
                                          FocusScope.of(context).unfocus();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
              ),
            );
          });
    },
  );
}
