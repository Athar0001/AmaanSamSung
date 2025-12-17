import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/generated/assets.dart';

import 'package:amaan_tv/Features/Home/data/models/share_parem_model.dart';
import 'package:amaan_tv/Features/family/provider/family_provider.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';
import 'package:provider/provider.dart';

void shareBottomSheet(BuildContext context, String showId) {
  final familyProvider = Provider.of<FamilyProvider>(context, listen: false);
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return DraggableScrollableSheet(
        maxChildSize: 0.8,
        minChildSize: 0.3,
        expand: false,
        builder: (_, scrollController) => ChangeNotifierProvider.value(
          value: familyProvider, // Use the provided instance
          child: Consumer<FamilyProvider>(
            builder: (context, provider, child) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      18.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalization.strings.share,
                                style: AppTextStylesNew.style16BoldAlmarai,
                              ),
                              4.verticalSpace,
                              Text(
                                AppLocalization.strings.shareWithYourFriends,
                                style: AppTextStylesNew.style14RegularAlmarai
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).textTheme.labelSmall?.color,
                                    ),
                              ),
                            ],
                          ),
                          const Icon(Icons.close),
                        ],
                      ),
                      16.verticalSpace,
                      const Divider(),
                      16.verticalSpace,
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                crossAxisCount: 4,
                                childAspectRatio: 0.8,
                              ),
                          itemCount:
                              provider.familyModel?.data?.noOfChildAccounts ??
                              0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                provider.setLoadingIndex(
                                  index,
                                ); // Set loading index
                                await provider.shareShow(
                                  model: ShareParamModel(
                                    childId: provider
                                        .familyModel!
                                        .data!
                                        .children![index]
                                        .id!,
                                    showId: showId,
                                  ),
                                );
                                provider.setLoadingIndex(
                                  null,
                                ); // Clear loading index
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: provider.loadingIndex == index
                                        ? AppCircleProgressHelper()
                                        : Container(
                                            width: double.infinity,
                                            decoration: containerDecoration(
                                              context,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Image.asset(
                                                      provider
                                                                  .familyModel
                                                                  ?.data
                                                                  ?.children![index]
                                                                  .relation ==
                                                              'Daughter'
                                                          ? Assets
                                                                .imagesGirl
                                                                .path
                                                          : Assets
                                                                .imagesSonAvatar
                                                                .path,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                  10.verticalSpace,
                                  Text(
                                    provider
                                            .familyModel
                                            ?.data
                                            ?.children![index]
                                            .fullName
                                            ?.split(' ')
                                            .first ??
                                        '',
                                    style: AppTextStylesNew.style16BoldAlmarai,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
