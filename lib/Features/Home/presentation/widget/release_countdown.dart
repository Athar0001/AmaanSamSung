import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;

import 'dart:async';

import 'package:amaan_tv/core/utils/app_localiztion.dart';
import 'package:amaan_tv/core/widget/radio%20button/radio_button_multi_select_package.dart';

class ReleaseCountdown extends StatefulWidget {
  const ReleaseCountdown({
    required this.releaseDate,
    super.key,
    this.showComingSoonBadge = true,
    this.accentColor = Colors.blue,
    this.fontFamily = 'Cairo',
  });
  final DateTime releaseDate;
  final bool showComingSoonBadge;
  final Color accentColor;
  final String fontFamily;

  @override
  State<ReleaseCountdown> createState() => _ReleaseCountdownState();
}

enum TimeUnit { days, hours, minutes, seconds }

class _ReleaseCountdownState extends State<ReleaseCountdown>
    with SingleTickerProviderStateMixin {
  late Timer _timer;

  Duration _timeLeft = Duration.zero;

  Map<TimeUnit, int> _previousValues = {
    TimeUnit.days: 0,
    TimeUnit.hours: 0,
    TimeUnit.minutes: 0,
    TimeUnit.seconds: 0,
  };

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft();
    });
  }

  void _calculateTimeLeft() {
    final newTimeLeft = widget.releaseDate.difference(DateTime.now());

    _previousValues = {
      TimeUnit.days: _timeLeft.inDays,
      TimeUnit.hours: _timeLeft.inHours % 24,
      TimeUnit.minutes: _timeLeft.inMinutes % 60,
      TimeUnit.seconds: _timeLeft.inSeconds % 60,
    };

    setState(() {
      _timeLeft = newTimeLeft;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDate(DateTime date, String locale) {
    final formatter = DateFormat('d MMMM y', locale); // 'ar' for Arabic locale
    formatter.useNativeDigits = false; // Use Arabic numerals
    return formatter.format(date);
  }

  Widget _buildTimeUnit(
    int newValue,
    String label,
    int previousValue, {
    bool toDigits = true,
  }) {
    return Container(
      decoration: containerDecoration(context),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Text(
            newValue.toString().padLeft(toDigits ? 2 : 0, '0'),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: widget.fontFamily,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).textTheme.labelSmall?.color,
              fontSize: 14,
              fontFamily: widget.fontFamily,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(
      widget.releaseDate,
      Localizations.localeOf(context).toLanguageTag(),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(
            context,
          ).textTheme.labelMedium!.color!.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${AppLocalization.strings.releaseDate} : $formattedDate',
                style: TextStyle(
                  // color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: widget.fontFamily,
                ),
                textDirection: TextDirection.rtl,
              ),
              if (widget.showComingSoonBadge)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: widget.accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        color: widget.accentColor,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppLocalization.strings.soon,
                        style: TextStyle(
                          color: widget.accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: widget.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildTimeUnit(
                _timeLeft.inDays,
                AppLocalization.strings.day,
                _previousValues[TimeUnit.days] ?? 0,
              ),
              _buildTimeUnit(
                _timeLeft.inHours % 24,
                AppLocalization.strings.hour,
                _previousValues[TimeUnit.hours] ?? 0,
              ),
              _buildTimeUnit(
                _timeLeft.inMinutes % 60,
                AppLocalization.strings.minute,
                _previousValues[TimeUnit.minutes] ?? 0,
              ),
              _buildTimeUnit(
                _timeLeft.inSeconds % 60,
                AppLocalization.strings.seconds,
                _previousValues[TimeUnit.seconds] ?? 0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
