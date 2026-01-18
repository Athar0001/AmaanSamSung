import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/listview_header_widget.dart';
import 'package:amaan_tv/Features/Home/presentation/widget/show_category_item.dart';
import 'package:amaan_tv/core/widget/circle_progress_helper.dart';
import 'package:amaan_tv/core/utils/enum.dart';

class SeriesContentView extends StatefulWidget {
  const SeriesContentView({super.key});

  @override
  State<SeriesContentView> createState() => _SeriesContentViewState();
}

class _SeriesContentViewState extends State<SeriesContentView> {
  int selectedCategoryIndex = 0;
  final ScrollController _scrollController = ScrollController();
  String? currentCategoryId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        // Initialize series data if needed
        if (provider.categoriesModel?.data == null &&
            provider.stateCategories != AppState.loading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.getCategoriesProvide();
          });
          return Center(child: AppCircleProgressHelper());
        }

        // Get series category
        final categories = provider.categoriesModel?.data;
        if (categories == null || categories.isEmpty) {
          return Center(child: Text('No categories available'));
        }

        final seriesCategory = categories.firstWhere(
          (cat) =>
              cat.name?.contains('مسلسلات') ??
              false || cat.name == "الأفلام و المسلسلات",
          orElse: () => categories.first,
        );

        // Set current category ID if not set
        if (currentCategoryId == null) {
          currentCategoryId = seriesCategory.id;
          selectedCategoryIndex = categories.indexOf(seriesCategory);
        }

        // Load shows for this category if not loaded and not loading
        if (provider.showsModel == null &&
            provider.stateShows != AppState.loading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            provider.getShowsCategoryProvide(categoryId: currentCategoryId);
          });
        }

        return RefreshIndicator(
          onRefresh: () async {
            await provider.getShowsCategoryProvide(
              categoryId: currentCategoryId,
            );
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Category tabs
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    10.verticalSpace,
                    if (categories.isNotEmpty)
                      SizedBox(
                        height: 150,
                        child: ListViewHeader(
                          items: categories,
                          selectedIndex: selectedCategoryIndex,
                          onSelect: (index) {
                            setState(() {
                              selectedCategoryIndex = index;
                              currentCategoryId = categories[index].id;
                              provider.getShowsCategoryProvide(
                                categoryId: currentCategoryId,
                              );
                            });
                          },
                        ),
                      ),
                  ],
                ),
              ),
              // Shows grid
              if (provider.stateShows == AppState.loading &&
                  provider.showsModel == null)
                SliverFillRemaining(
                  child: Center(child: AppCircleProgressHelper()),
                )
              else if (provider.stateShows == AppState.error)
                SliverFillRemaining(
                  child: Center(child: Text(provider.stateShows.msg)),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.all(8.w),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 20.r,
                      mainAxisSpacing: 20.r,
                    ),
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final show = provider.showsModel!.data![index];
                      return ShowCategoryItemWidget(
                        model: show,
                        height: double.infinity,
                        width: double.infinity,
                      );
                    }, childCount: provider.showsModel?.data?.length ?? 0),
                  ),
                ),
              // Loading indicator
              if (provider.isLoadingMore)
                SliverToBoxAdapter(
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              // Bottom spacing
              SliverToBoxAdapter(child: 130.verticalSpace),
            ],
          ),
        );
      },
    );
  }
}
