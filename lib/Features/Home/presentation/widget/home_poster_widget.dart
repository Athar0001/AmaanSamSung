import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'banner/tablet_banner_view.dart';

class HomeBannerWidget extends StatefulWidget {
  const HomeBannerWidget({super.key});

  @override
  HomeBannerState createState() => HomeBannerState();
}

class HomeBannerState extends State<HomeBannerWidget> {
  final PageController _controller = PageController();
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoSlide();
    });
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (_controller.hasClients) {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        final bannerLength = provider.bannerModel?.data?.length ?? 0;
        final totalPages = bannerLength + 1; // +1 for cover image at index 0

        int nextPage;
        if (_currentPage < totalPages - 1) {
          nextPage = _currentPage + 1;
        } else {
          nextPage = 0;
        }

        print(
          'Auto-slide: current=$_currentPage, total=$totalPages, next=$nextPage, bannerLength=$bannerLength',
        );

        _controller.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Container(
        color: Colors.transparent,
        height: 400,
        child: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            return TabletBannerView(
              controller: _controller,
              currentPage: _currentPage,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              provider: provider,
            );
          },
        ),
      ),
    );
  }
}
