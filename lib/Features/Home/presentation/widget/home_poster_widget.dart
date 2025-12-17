import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/Clippers/layour_clipper.dart';
import 'package:amaan_tv/Features/Home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'banner/mobile_banner_view.dart';
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
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_controller.hasClients) {
        final provider = Provider.of<HomeProvider>(context, listen: false);
        final bannerLength = provider.bannerModel?.data?.length ?? 0;
        if (_currentPage < bannerLength - 1) {
          _currentPage++;
        } else {
          _currentPage = 0;
        }

        _controller.animateToPage(
          _currentPage,
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
    final isTablet = 1.sw > 600;
    return SizedBox(
      height: 540.r,
      child: ClipPath(
        clipper: BottomCurveClipper(deepCurve: 70.r),
        child: Container(
          color: Colors.black,
          height: 540.r,
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return isTablet
                  ? TabletBannerView(
                      controller: _controller,
                      currentPage: _currentPage,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      provider: provider,
                    )
                  : MobileBannerView(
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
      ),
    );
  }
}
