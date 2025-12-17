import 'package:amaan_tv/core/widget/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:amaan_tv/core/utils/app_router.dart';
import '../Themes/app_colors_new.dart';
import '../Themes/app_text_styles_new.dart';
import '../error/failure.dart';
import 'package:country_picker/country_picker.dart';

String formatSecondsToMinutes(int seconds) {
  final minutes = seconds ~/ 60; // Get the whole minutes
  final remainingSeconds = seconds % 60; // Get the remaining seconds

  final formattedTime =
      '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  return formattedTime;
}

void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    backgroundColor: AppColorsNew.primary,
    content: Text(
      text,
      style: AppTextStylesNew.style18BoldAlmarai.copyWith(
        color: AppColorsNew.white,
      ),
    ),
    duration: const Duration(seconds: 5),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

dynamic checkFailure(response) {
  if (response is Failure) {
    AppToast.show(response.message);
    return false;
  } else {
    return response;
  }
}

String getCountryNameByCode(String countryCode) {
  // final country = Country.tryParse(countryCode);
  final country = Country.tryParse(countryCode); // For Arabic
  if (country != null) {
    return country.getTranslatedName(appNavigatorKey.currentContext!)!;
  }
  return '';
}

double calculateProgress(String fromMinute, double duration) {
  // Parse `fromMinute` into seconds
  if (duration == 0) {
    duration = 1;
  }
  var fromMinuteSeconds = parseTimeToSeconds(fromMinute);
  // Ensure `fromMinute` does not exceed `duration`
  if (fromMinuteSeconds > duration) {
    fromMinuteSeconds = duration.toDouble(); // Cap it at the video duration
  }

  // Calculate the percentage
  final progress = fromMinuteSeconds / duration;
  return progress;
}

Duration parseDuration(String time) {
  final parts = time.split(':');
  if (parts.length == 3) {
    final hours = double.parse(parts[0]);
    final minutes = double.parse(parts[1]);
    final seconds = double.parse(parts[2].substring(0, 2));
    return Duration(
      hours: hours.toInt(),
      minutes: minutes.toInt(),
      seconds: seconds.toInt(),
    );
  } else if (parts.length == 2) {
    final minutes = double.parse(parts[0]);
    final seconds = double.parse(parts[1].substring(0, 2));
    return Duration(minutes: minutes.toInt(), seconds: seconds.toInt());
  } else if (!time.contains(':')) {
    final seconds = int.parse(parts[0].substring(0, 2));
    return Duration(seconds: seconds);
  } else {
    final days = double.parse(parts[0]);
    final hours = double.parse(parts[1]);
    final minutes = double.parse(parts[2]);
    final seconds = double.parse(parts[3].substring(0, 2));
    return Duration(
      days: days.toInt(),
      hours: hours.toInt(),
      minutes: minutes.toInt(),
      seconds: seconds.toInt(),
    );
  }
}

double parseTimeToSeconds(String time) {
  try {
    // Split by ":" to get hours, minutes, and seconds
    final parts = time.split(':');
    final hours = double.parse(parts[0]);
    final minutes = double.parse(parts[1]);
    final seconds = double.parse(parts[2]);

    // Convert to total seconds
    return (hours * 3600) + (minutes * 60) + seconds;
  } catch (e) {
    print('Invalid time format: $time');
    return 0; // Default to 0 if parsing fails
  }
}

double parseTimeToDecimal(String time) {
  try {
    // Step 1: Break the time apart like a treasure map 🗺️
    final parts = time.split(':');
    final hours = double.parse(parts[0]); // Extract hours 🕒
    final minutes = double.parse(parts[1]); // Extract minutes ⏱️
    final seconds = double.parse(parts[2]); // Extract seconds ⌛

    // Step 2: Stir the ingredients into the decimal hours potion 🧪
    final totalHours = hours + (minutes / 60) + (seconds / 3600);
    return double.parse(totalHours.toStringAsFixed(2));
  } catch (e) {
    print('Invalid time format: $time');
    return 0; // Default to 0 if parsing fails
  }
}

double calcReelsNum(int lenght) {
  switch (lenght) {
    case <= 1:
      return 0.4;
    case 2:
      return 0.3;
    case 3:
      return 0.3;
    case > 3:
      return 0.2;
  }
  return 0.2;
}

void showCustomToast({required BuildContext context, required String message}) {
  final fToast = FToast();
  fToast.init(context);

  fToast.showToast(
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: AppColorsNew.darkGrey3.withOpacity(0.9),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: AppColorsNew.white, width: 0.5),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ), // White text
      ),
    ),
    gravity: ToastGravity.TOP,
    toastDuration: Duration(seconds: 2),
  );
}

String extractMiddlePart(String url) {
  final uri = Uri.parse(url);
  var path = uri.path;

  // Remove the leading slash if present
  if (path.startsWith('/')) {
    path = path.substring(1);
  }

  // Split by slash and get all segments except the last one (the filename)
  final segments = path.split('/');
  if (segments.length > 1) {
    // Return everything except the last segment
    return segments[0];
  }

  return path;
}
