import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amaan_tv/core/Themes/app_colors_new.dart';
import 'package:amaan_tv/core/Themes/app_text_styles_new.dart';
import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/buttons/main_button.dart';

Future<Duration?> showDurationPicker(BuildContext context,
    {Duration? initialDuration}) async {
  return showModalBottomSheet<Duration>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32.0),
      ),
    ),
    builder: (context) {
      return DurationPicker(initialDuration: initialDuration);
    },
  );
}

class DurationPicker extends StatefulWidget {

  const DurationPicker({super.key, this.initialDuration});
  final Duration? initialDuration;

  static Future<Duration?> show(BuildContext context,
      {Duration? initialDuration}) {
    return showDurationPicker(context, initialDuration: initialDuration);
  }

  @override
  State<DurationPicker> createState() => DurationPickerState();
}

class DurationPickerState extends State<DurationPicker> {
  late int hours;
  late int minutes;

  @override
  void initState() {
    super.initState();
    hours = widget.initialDuration?.inHours ?? 0;
    minutes = widget.initialDuration?.inMinutes.remainder(60) ?? 0;
  }

  void _updateDuration(int newHours, int newMinutes) {
    setState(() {
      hours = newHours;
      minutes = newMinutes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text(
            //   AppLocalization.strings.selectDuration,
            //   style: AppTextStylesNew.style16ExtraBoldAlmarai,
            // ),
            // const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              textDirection: TextDirection.ltr,
              children: [
                _NumberPickerWidget(
                  title: AppLocalization.strings.hours,
                  value: hours,
                  max: 23,
                  onChanged: (value) {
                    _updateDuration(value, minutes);
                  },
                ),
                _NumberPickerWidget(
                  title: AppLocalization.strings.minutes,
                  value: minutes,
                  max: 59,
                  onChanged: (value) {
                    _updateDuration(hours, value);
                  },
                ),
              ],
            ),
            32.verticalSpace,
            MainButtonWidget(
              onTap: () {
                Navigator.pop(
                  context,
                  Duration(hours: hours, minutes: minutes),
                );
              },
              label: AppLocalization.strings.ok,
            ),
          ],
        ),
      ),
    );
  }
}

class _NumberPickerWidget extends StatelessWidget {

  const _NumberPickerWidget({
    required this.title,
    required this.value,
    required this.max,
    required this.onChanged,
  });
  final String title;
  final int value;
  final int max;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStylesNew.style14BoldAlmarai,
        ),
        32.verticalSpace,
        SizedBox(
          height: 150,
          width: 120,
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(initialItem: value),
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            diameterRatio: 3,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 200),
                  style: TextStyle(
                    color: index == value
                        ? AppColorsNew.brightOrange
                        : Theme.of(context).textTheme.bodyMedium?.color,
                    fontSize: index == value ? 21 : 16,
                    fontWeight:
                        index == value ? FontWeight.bold : FontWeight.normal,
                  ),
                  child: Center(child: Text(index.toString())),
                );
              },
              childCount: max + 1,
            ),
            onSelectedItemChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
