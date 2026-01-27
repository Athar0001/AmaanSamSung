import 'package:flutter/material.dart';
import 'package:amaan_tv/core/widget/tv_click_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/responsive/models/responsive_sizes.dart';
import 'package:amaan_tv/core/widget/responsive/responsive_size_builder.dart';

class HerosWidget extends StatelessWidget {
  const HerosWidget({
    required this.characters,
    super.key,
    this.charactersScrollController,
  });

  final List<CharacterData> characters;
  final ScrollController? charactersScrollController;

  @override
  Widget build(BuildContext context) {
    final characterSizes = ResponsiveSizes(
      small: Size.square(80.r),
      medium: Size.square(100.r),
      large: Size.square(130.r),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        characters.length,
        (index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: TvClickButton(
            focusScale: 1.1,
            onTap: () {
              context.pushNamed('character', extra: characters[index]);
            },
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    ResponsiveSizeBuilder(
                      sizes: characterSizes,
                      builder: (context, size) {
                        return Container(
                          height: size.height,
                          width: size.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: decorationImageHelper(
                              characters[index].backgroundImage?.url,
                            ),
                          ),
                        );
                      },
                    ),
                    Hero(
                      tag: characters[index].id.toString(),
                      child: ResponsiveSizeBuilder(
                        sizes: ResponsiveSizes(
                          small: Size(100.r, 110.r),
                          medium: Size(120.r, 130.r),
                          large: Size(150.r, 160.r),
                        ),
                        builder: (context, size) => CachedNetworkImageHelper(
                          showShimmer: false,
                          height: size.height,
                          width: size.width,
                          fit: BoxFit.fill,
                          imageUrl: characters[index].image?.url,
                        ),
                      ),
                    ),
                  ],
                ),
                5.verticalSpace,
                ResponsiveSizeBuilder(
                  sizes: characterSizes,
                  builder: (context, size) {
                    return SizedBox(
                      width: size.width,
                      child: Text(
                        characters[index].name!,
                        textAlign: TextAlign.center,
                        style: AppTextStylesNew.style14RegularAlmarai,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
