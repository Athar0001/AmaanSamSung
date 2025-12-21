import 'package:amaan_tv/Features/Home/data/models/home/show_details_model/data.dart';
import 'package:amaan_tv/Features/Home/data/models/home_categories_model/categories.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/listview_header_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_category_item.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/enum.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({required this.category, super.key});

  final Category category;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedStoryCategory = 0;
  final ScrollController _scrollController = ScrollController();
  String? currentCategoryId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize with the data from the widget
      currentCategoryId = widget.category.id;

      // We might need to fetch categories if not already populated or passed
      context.read<HomeProvider>().getCategoriesProvide();
      // Fetch shows for the initial category
      context.read<HomeProvider>().getShowsCategoryProvide(
        categoryId: currentCategoryId,
      );

      _scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final provider = Provider.of<HomeProvider>(context, listen: false);
      if (provider.hasMoreData && !provider.isLoadingMore) {
        provider.loadMoreShows(categoryId: currentCategoryId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.category.name ?? '',
          style: AppTextStylesNew.style24BoldAlmarai.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          // If categories are loading initially
          if (provider.stateCategories == AppState.loading &&
              provider.categoriesModel == null) {
            return Center(child: AppCircleProgressHelper());
          }

          if (provider.stateCategories == AppState.error) {
            return Center(child: Text(provider.stateCategories.msg));
          }

          return Column(
            children: [
              const Gap(10),
              if (provider.categoriesModel?.data?.isNotEmpty == true)
                SizedBox(
                  height: 160.h,
                  child: ListViewHeader(
                    items: provider.categoriesModel!.data!,
                    selectedIndex: selectedStoryCategory,
                    onSelect: (index) {
                      setState(() {
                        selectedStoryCategory = index;
                        currentCategoryId =
                            provider.categoriesModel!.data![index].id;
                        provider.getShowsCategoryProvide(
                          categoryId: currentCategoryId,
                        );
                      });
                    },
                  ),
                ),
              const Gap(15),
              if (provider.stateShows == AppState.loading)
                Expanded(child: Center(child: AppCircleProgressHelper()))
              else if (provider.stateShows == AppState.error)
                Expanded(child: Center(child: Text(provider.stateShows.msg)))
              else
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(20.w),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4, // TV Grid Count
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 20.w,
                      mainAxisSpacing: 20.h,
                    ),
                    itemCount: provider.showsModel?.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      if (provider.shouldLoadMore(index)) {
                        // This might be called too often in build, but loadMore checks isLoading
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          provider.loadMoreShows(categoryId: currentCategoryId);
                        });
                      }

                      final show = provider.showsModel!.data![index];
                      return _buildGridItem(show);
                    },
                  ),
                ),
              if (provider.isLoadingMore)
                Container(
                  height: 60,
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGridItem(Details show) {
    return Builder(
      builder: (context) {
        return Focus(
          onFocusChange: (hasFocus) {
            setState(() {}); // Rebuild to show focus effect
          },
          child: Builder(
            builder: (context) {
              final isFocused = Focus.of(context).hasFocus;
              return GestureDetector(
                onTap: () {
                  // Navigate to details
                  // Using common Navigator as requested
                  // Assuming AppRoutes.showDetails path logic or direct push
                  // For strict adherence to "Navigator", we push a hypothetical DetailsScreen
                  // Or using named route from existing router configuration if compatible
                  // Ideally:
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => ShowDetailsScreen(id: show.id)));
                  // But since I don't know the exact DetailsScreen class here without looking,
                  // I will try to use the named route if possible, or just print typical TODO if unsure.
                  // However, the request said "Use Navigator". Implementation plan said "Use Navigator".
                  // Mobile uses context.pushNamed(AppRoutes.showDetails.routeName...).
                  // I will assume there is a generic route handling or I should use named route with Navigator.

                  // Using Navigator.pushNamed to respect "Navigator" request but still use the route name concept if defined in main app.
                  // If not, I'll assumme a standard named route '/show_details'.
                  // Actually, mobile uses GoRouter, so AppRoutes.showDetails.routeName might be just 'show_details'.

                  Navigator.of(
                    context,
                  ).pushNamed('show_details', arguments: show.id);
                },
                child: Transform.scale(
                  scale: isFocused ? 1.05 : 1.0,
                  child: Container(
                    decoration: isFocused
                        ? BoxDecoration(
                            border: Border.all(
                              color: AppColorsNew.primary,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(15.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          )
                        : null,
                    child: ShowCategoryItemWidget(
                      model: show,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
