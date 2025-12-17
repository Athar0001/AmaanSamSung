import 'dart:async';
import 'package:flutter/material.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import 'package:amaan_tv/Features/Home/data/data_source/reels_service.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/comment_parm_model.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/comments_reels_model/comments_reels_model.dart';
import 'package:amaan_tv/Features/Home/data/models/reels/comments_reels_model/user.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/utils/cash_services/cashe_helper.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:provider/provider.dart';
import '../../../core/widget/app_toast.dart';

class ReelProvider extends ChangeNotifier {
  ReelProvider(this.reelsService);
  ReelsService reelsService;

  int currentReelIndex = 0;
  void setCurrentReelIndex(int index) {
    currentReelIndex = index;
  }

  Future<void> likeReel(String id) async {
    final result = await reelsService.likeReel(reelId: id);
    result.fold((failure) {
      AppToast.show(failure.message);
      throw failure;
    }, (_) => null);
  }

  /////////////////////////////////////////////////////////////////////////////////
  List<CommentsReelsModel>? _commentModel;
  List<CommentsReelsModel>? get commentsReelsModel => _commentModel;
  AppState stateCommentsReels = AppState.init;
  Future getCommentsReels({required String reelId}) async {
    stateCommentsReels = AppState.loading;
    _commentModel = null;
    notifyListeners();
    (await reelsService.getCommentsReels(reelId: reelId)).fold(
      (failure) {
        stateCommentsReels = AppState.error;
        stateCommentsReels.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        _commentModel = data;
        stateCommentsReels = AppState.success;
        notifyListeners();
      },
    );
  }
  /////////////////////////////////////////////////////////////////////////////////

  Future likeReelComment(String id) async {
    notifyListeners();
    (await reelsService.likeReelComment(commentId: id)).fold(
      (failure) {
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        notifyListeners();
      },
    );
  }

  void toggleLikeState(int index) {
    if (commentsReelsModel != null && index < commentsReelsModel!.length) {
      commentsReelsModel![index].isLiked = !commentsReelsModel![index].isLiked;
      notifyListeners();
    }
  }

  /////////////////////////////////////////////////////////////////////////////////
  final reel = Provider.of<HomeProvider>(
    appNavigatorKey.currentContext!,
  ).reelsHomeModel!.data!;
  AppState stateMakeCommentsReels = AppState.init;
  Future makeCommentsReels({required CommentParmModel model}) async {
    stateMakeCommentsReels = AppState.loading;
    notifyListeners();
    (await reelsService.makeCommentReels(model: model)).fold(
      (failure) {
        stateMakeCommentsReels = AppState.error;
        stateMakeCommentsReels.errorMsg(error: failure.message);
        AppToast.show(failure.message);
        notifyListeners();
      },
      (data) {
        final newComment = CommentsReelsModel(
          id: data.id, // Unique ID for the comment
          comment: data.comment,
          isLiked: data.isLiked, // Default state
          user: User(
            fullName: CacheHelper
                .currentUser!
                .name, // Replace with the logged-in user's name
          ),
        );

        commentsReelsModel!.add(newComment);
        stateMakeCommentsReels = AppState.success;
        notifyListeners();
      },
    );
  }
}
