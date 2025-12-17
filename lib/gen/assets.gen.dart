import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Assets {
  static const images = GenImages();

  static AssetGenImage get imagesGirl => images.imagesGirl;
  static AssetGenImage get imagesSonAvatar => images.imagesSonAvatar;
  static AssetGenImage get imagesPlay => images.imagesPlay;
  static AssetGenImage get imagesLock => images.imagesLock;
  static AssetGenImage get imagesGames => images.imagesGames;
  static AssetGenImage get imagesTrueHeart => images.imagesTrueHeart;
  static AssetGenImage get imagesFalseHeart => images.imagesFalseHeart;
}

class GenImages {
  const GenImages();

  AssetGenImage get home => const AssetGenImage('assets/images/home.png');
  AssetGenImage get activeHome =>
      const AssetGenImage('assets/images/home_active.png');
  AssetGenImage get search => const AssetGenImage('assets/images/search.png');
  AssetGenImage get activeSearch =>
      const AssetGenImage('assets/images/search_active.png');
  AssetGenImage get games => const AssetGenImage('assets/images/games.png');
  AssetGenImage get videos => const AssetGenImage('assets/images/videos.png');
  AssetGenImage get activeVideos =>
      const AssetGenImage('assets/images/videos_active.png');
  AssetGenImage get profile => const AssetGenImage('assets/images/profile.png');
  AssetGenImage get activeProfile =>
      const AssetGenImage('assets/images/profile_active.png');
  AssetGenImage get mykids => const AssetGenImage('assets/images/mykids.png');
  AssetGenImage get activemykids =>
      const AssetGenImage('assets/images/mykids_active.png');
  AssetGenImage get setting => const AssetGenImage('assets/images/setting.png');
  AssetGenImage get activeSettings =>
      const AssetGenImage('assets/images/setting_active.png');

  AssetGenImage get imagesYoutube =>
      const AssetGenImage('assets/images/youtube.png');
  AssetGenImage get imagesShare =>
      const AssetGenImage('assets/images/share.png');

  AssetGenImage get signal => const AssetGenImage('assets/images/signal.png');
  AssetGenImage get tasks => const AssetGenImage('assets/images/tasks.png');
  AssetGenImage get lock => const AssetGenImage('assets/images/lock.png');

  AssetGenImage get rate1 => const AssetGenImage('assets/images/rate1.png');
  AssetGenImage get rate2 => const AssetGenImage('assets/images/rate2.png');
  AssetGenImage get rate3 => const AssetGenImage('assets/images/rate3.png');
  AssetGenImage get rate4 => const AssetGenImage('assets/images/rate4.png');
  AssetGenImage get rate5 => const AssetGenImage('assets/images/rate5.png');

  AssetGenImage get imagesGames =>
      const AssetGenImage('assets/images/games.png');
  AssetGenImage get imagesPlay => const AssetGenImage('assets/images/play.png');
  AssetGenImage get imagesLock => const AssetGenImage('assets/images/lock.png');
  AssetGenImage get imagesGirl => const AssetGenImage('assets/images/girl.png');
  AssetGenImage get imagesSonAvatar =>
      const AssetGenImage('assets/images/boy.png');
  AssetGenImage get imagesTrueHeart =>
      const AssetGenImage('assets/images/heart_true.png');
  AssetGenImage get imagesFalseHeart =>
      const AssetGenImage('assets/images/heart_false.png');
}

class AssetGenImage {
  final String path;
  const AssetGenImage(this.path);

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      path,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  Widget svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    Color? color,
    BlendMode colorBlendMode = BlendMode.srcIn,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    Clip clipBehavior = Clip.hardEdge,
    bool cacheColorFilter = false,
    SvgTheme? theme,
  }) {
    return SvgPicture.asset(
      path,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      color: color,
      colorBlendMode: colorBlendMode,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
      theme: theme,
    );
  }
}
