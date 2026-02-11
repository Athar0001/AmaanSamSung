import 'package:amaan_tv/Features/Home/presentation/widget/show_category_item.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/Features/favorite/presentation/widgets/favorite_icon_button.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/helpers/extentions/context.dart';
import 'package:amaan_tv/core/models/characters_model.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/utils/grid_config.dart';
import 'package:amaan_tv/core/widget/buttons/back_button.dart';
import 'package:amaan_tv/core/widget/buttons/row_buttons.dart';
import 'package:amaan_tv/core/widget/cached%20network%20image/cached_network_image.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:amaan_tv/core/widget/text_height_fitter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';

import '../../../../core/utils/focus_helper.dart';
import '../../../../core/widget/tv_click.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({required this.character, super.key});

  final CharacterData character;

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().getShowsCategoryProvide(
            characterId: widget.character.id,
          );
      context.setFocus(FocusId.list(FocusKeys.charactersTab, 0),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TvClick(
                id: FocusKeys.charactersBack,
                downId: FocusId.list(FocusKeys.charactersTab, 0),
                onSelect: (){
                  Navigator.pop(context);
                },
                child: BackButtonWidget()),
          ),
          24.verticalSpace,
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(40.r),
              ),
              border: Border(bottom: BorderSide(color: AppColorsNew.darkBlue1)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.r),
              child: Row(
                children: [
                  Container(
                    height: 208.r,
                    width: 160.r,
                    decoration: BoxDecoration(
                      // border: Border.all(color: AppColorsNew.blue1),
                      borderRadius: BorderRadius.circular(20.r),
                      image: decorationImageHelper(
                        widget.character.backgroundImage?.url ??
                            'https://img.freepik.com/free-vector/flat-nature-background_1308-20252.jpg',
                        cacheKey:
                            'backgroundImage:${widget.character.backgroundImage?.name}',
                      ),
                    ),
                    child: Hero(
                      tag: widget.character.id.toString(),
                      child: Container(
                        height: 262.r,
                        width: 162.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: CachedNetworkImageHelper(
                          fit: BoxFit.fitHeight,
                          height: double.infinity,
                          width: double.infinity,
                          imageUrl: widget.character.image?.url,
                        ),
                      ),
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextHeightFitter(
                          text: widget.character.name ?? '',
                          maxWidth: context.width * 0.60,
                          maxLines: 5,
                          style: AppTextStylesNew.style40ExtraBoldAlmarai
                              .copyWith(color: AppColorsNew.blue4),
                        ),
                        24.verticalSpace,
                        Text(
                          widget.character.description ?? '',
                          style: AppTextStylesNew.style14RegularAlmarai,
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          24.verticalSpace,
          SizedBox(
            height: 50,
            child: RowButtonsWidget(
              selectedIndex: currentIndex,
              focusKeyBase: FocusKeys.charactersTab,
              downId: FocusId.grid(FocusKeys.charactersList, 0, 0),
              upId: FocusKeys.charactersBack,
              items: [
                AppLocalization.strings.series,
                AppLocalization.strings.programes,
                AppLocalization.strings.games,
              ],
              onChanged: (index) {
                currentIndex = index;
                setState(() {});
              },
            ),
          ),
          24.verticalSpace,
          if (currentIndex == 0) ...[
            Consumer<HomeProvider>(
              builder: (context, provider, child) {
                return provider.stateShows == AppState.loading
                    ? AppCircleProgressHelper()
                    : provider.stateShows == AppState.error
                        ? SizedBox()
                        : provider.showsModel?.data == null ||
                                provider.showsModel!.data!.isEmpty
                            ? Center(child: Text('No shows available'))
                            : Expanded(
                                child: GridView.builder(
                                  shrinkWrap: false,
                                  padding: GridConfig.getDefaultPadding(),
                                  gridDelegate:
                                      GridConfig.getDefaultGridDelegate(),
                                  itemBuilder: (context, index) {
                                    const columns = 6;
                                    final row = index ~/ columns;
                                    final col = index % columns;
                                    final totalRows = (provider.showsModel!.data!.length / columns).ceil();
                                     return Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: TvClick(
                                            id: FocusId.grid(
                                                FocusKeys.charactersList, row, col),
                                         listBaseId: FocusKeys.charactersList,
                                         rightId: col > 0
                                             ? FocusId.grid(FocusKeys.charactersList, row, col - 1)
                                             : null,
                                         leftId: col < columns - 1 && (row * columns + col + 1) < provider.showsModel!.data!.length
                                             ? FocusId.grid(FocusKeys.charactersList, row, col + 1)
                                             : null,
                                         upId: row > 0
                                             ? FocusId.grid(FocusKeys.charactersList, row - 1, col)
                                             : FocusId.list(FocusKeys.charactersTab, 0),
                                         downId: row < totalRows - 1 && ((row + 1) * columns + col) < provider.showsModel!.data!.length
                                             ? FocusId.grid(FocusKeys.charactersList, row + 1, col)
                                             : null,
                                         radius: 12.r,
                                         onSelect: () async {
                                           final showData =
                                           provider.showsModel?.data?[index];
                                           if (showData?.id != null) {
                                             context.pushNamed(
                                               'showDetails',
                                               pathParameters: {
                                                 'id': showData!.id
                                                     .toString(),
                                               },
                                             );
                                           }
                                         },
                                            child: ShowCategoryItemWidget(
                                              model: provider.showsModel!
                                                  .data![index],
                                            ),
                                          ),
                                     );
                                  },
                                  itemCount:
                                      provider.showsModel?.data?.length ?? 0,
                                ),
                              );
              },
            ),
          ]
          // else
          //   Expanded(child: SoonScreen(backButton: false)),
        ],
      ),
    );
  }
}
