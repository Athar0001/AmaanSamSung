import 'dart:async';
import 'package:amaan_tv/Features/Auth/provider/auth_provider.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/widget/buttons/main_button.dart';
import 'package:amaan_tv/core/widget/scaffold_gradient_background.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:go_router/go_router.dart';
import 'package:amaan_tv/core/utils/app_router.dart';

import '../../../../core/injection/injection_imports.dart' as di;
import '../../../../core/services/signalr_service.dart';
import '../../../../core/widget/tv_click_button.dart';

class QRLoginScreen extends StatefulWidget {
  final String? qrData;
  final Duration expiryDuration;
  final VoidCallback? onExpired;
  final VoidCallback? onRefresh;

  const QRLoginScreen({
    super.key,
    this.qrData,
    this.expiryDuration = const Duration(minutes: 3),
    this.onExpired,
    this.onRefresh,
  });

  @override
  State<QRLoginScreen> createState() => _QRLoginScreenState();
}

class _QRLoginScreenState extends State<QRLoginScreen> {
  Timer? _timer;
  late Duration _remainingTime;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.expiryDuration;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = context.read<AuthProvider>();
      authProvider.generateQr((user) {
        context.goNamed(AppRoutes.home.routeName);
      }).then((_) {
        // Update remaining time from server response
        setState(() {
          _remainingTime = authProvider.expiryDuration;
        });
        _timer?.cancel();
        _startTimer();
      });
    });
  }

  void _startTimer() {
    setState(() {
      _isExpired = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime.inSeconds <= 0) {
        timer.cancel();
        setState(() {
          _isExpired = true;
        });
        widget.onExpired?.call();
      } else {
        setState(() {
          _remainingTime = Duration(seconds: _remainingTime.inSeconds - 1);
        });
      }
    });
  }

  void _regenerateQr() {
    final authProvider = context.read<AuthProvider>();
    authProvider.generateQr((user) {
      context.goNamed(AppRoutes.home.routeName);
    }).then((_) {
      setState(() {
        _remainingTime = authProvider.expiryDuration;
        _isExpired = false;
      });
      _timer?.cancel();
      _startTimer();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      body: SafeArea(
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.r),
                  // Main title
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.r),
                    child: Text(AppLocalization.strings.qrLoginTitle,
                        textAlign: TextAlign.center,
                        style: AppTextStylesNew.style28BoldAlmarai),
                  ),
                  SizedBox(height: 15.r),

                  // Subtitle
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.r),
                    child: Text(
                      AppLocalization.strings.qrLoginSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStylesNew.style18RegularAlmarai.copyWith(
                        color: AppColorsNew.grey1,
                      ),
                    ),
                  ),
                  SizedBox(height: 60.h),

                  // QR Code Container
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: authProvider.state == AuthState.loading
                        ? CircularProgressIndicator()
                        : QrImageView(
                            data: authProvider.qrData,
                            version: QrVersions.auto,
                            size: 450.r,
                            backgroundColor: Colors.white,
                            eyeStyle: const QrEyeStyle(
                              eyeShape: QrEyeShape.square,
                              color: Colors.black,
                            ),
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.square,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  SizedBox(height: 25.r),

                  // Timer or Expired message
                  if (_isExpired)
                    Text(
                      AppLocalization.strings.qrCodeExpired,
                      style: AppTextStylesNew.style18RegularAlmarai.copyWith(
                        color: AppColorsNew.red1,
                      ),
                    )
                  else
                    Text(
                      AppLocalization.strings.qrCodeExpiresIn +
                          " " +
                          _formatDuration(_remainingTime),
                      style: AppTextStylesNew.style18RegularAlmarai.copyWith(
                        color: AppColorsNew.grey1,
                      ),
                    ),
                  SizedBox(height: 16.r),

                  // Try Again button (shown when expired)
                  if (_isExpired)
                    TvClickButton(
                      onTap: _regenerateQr,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.r,
                          vertical: 12.r,
                        ),
                        decoration: BoxDecoration(
                          color: AppColorsNew.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh,
                              color: Colors.white,
                              size: 20.r,
                            ),
                            SizedBox(width: 8.r),
                            Text(
                              AppLocalization.strings.tryAgain,
                              style:
                                  AppTextStylesNew.style16BoldAlmarai.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(height: 20.r),

                  // Navigate to Home button
                  // MainButtonWidget(
                  //   onTap: () {
                  //     context.goNamed(AppRoutes.home.routeName);
                  //   },
                  //   width: 250,
                  //   borderWidth: 1,
                  //   label: AppLocalization.strings.skipOrJoinAsGuest,
                  // ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
