// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:amaan_tv/Themes/app_colors_new.dart';
// import 'package:amaan_tv/Themes/app_text_styles_new.dart';
// import 'package:amaan_tv/ui/Home/data/models/home/related_model/related_model.dart';
// import 'package:amaan_tv/ui/Home/presentation/widget/category_item_widget.dart';
// import 'package:amaan_tv/utils/app_localiztion.dart';
// import 'package:amaan_tv/utils/constant.dart';
// import 'package:amaan_tv/widget/buttons/back_button.dart';
// import 'package:amaan_tv/widget/scaffold_gradient_background.dart';

// class SuggetionsScreen extends StatelessWidget {
//   const SuggetionsScreen({super.key, required this.relatedModel});
//   final RelatedModel relatedModel;
//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldGradientBackground(
//       appBar: AppBar(
//         title: Text(AppLocalization.strings.suggestionsForYou),
//         leading: const BackButtonWidget(),
//       ),
//       body: Padding(
//           padding:
//               const EdgeInsets.symmetric(horizontal: Constant.paddingLeftRight),
//           child: Padding(
//             padding: EdgeInsets.only(top: 24.h),
//             child: GridView.builder(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16.h,
//                 crossAxisSpacing: 16.w,
//                 childAspectRatio: 163.w / 165.h,
//               ),
//               itemCount: relatedModel.data!.length,
//               itemBuilder: (context, index) => Stack(
//                 alignment: AlignmentDirectional.center,
//                 children: [
//                   CategoryItemWidget(
//                     image: relatedModel.data![index].thumbnailImage?.url,
//                     isFavourite: relatedModel.data![index].isFavourite,
//                   ),
//                   Positioned(
//                     bottom: 10.h,
//                     child: Text(
//                       relatedModel.data![index].title!,
//                       style: AppTextStylesNew.style14RegularAlmarai.copyWith(
//                         color: AppColorsNew.white1,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )),
//     );
//   }
// }
