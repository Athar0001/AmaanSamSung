import 'package:amaan_tv/core/widget/tv_click.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_tv_navigation/simple_tv_navigation.dart';

import '../utils/focus_helper.dart';

class TvKeyboardOverlay extends StatefulWidget {
  const TvKeyboardOverlay({
    super.key,
    required this.controller,
    required this.onDone,
    required this.onSearch,
    this.initialArabic = true,
  });

  final TextEditingController controller;
  final VoidCallback onDone;
  final VoidCallback onSearch;
  final bool initialArabic;

  @override
  State<TvKeyboardOverlay> createState() => _TvKeyboardOverlayState();
}

class _TvKeyboardOverlayState extends State<TvKeyboardOverlay> {
  late bool isArabic;
  bool shift = false;

  @override
  void initState() {
    super.initState();
    isArabic = widget.initialArabic;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.setFocus(FocusId.grid(FocusKeys.kb, 0, 0));
    });
  }

  void _insert(String s) {
    final text = widget.controller.text;
    widget.controller.text = text + s;
    widget.controller.selection = TextSelection.collapsed(
      offset: widget.controller.text.length,
    );
    setState(() {});
  }

  void _backspace() {
    final text = widget.controller.text;
    if (text.isEmpty) return;
    widget.controller.text = text.substring(0, text.length - 1);
    widget.controller.selection = TextSelection.collapsed(
      offset: widget.controller.text.length,
    );
  }

  void _clear() {
    context.setFocus(FocusKeys.searchInput);
    Navigator.pop(context);
  }

  List<List<String>> get _enLayout => [
    ['q','w','e','r','t','y','u','i','o','p'],
    ['a','s','d','f','g','h','j','k','l'],
    ['z','x','c','v','b','n','m'],
  ];

  // Simple Arabic TV layout (you can customize)
  List<List<String>> get _arLayout => [
    ['ض','ص','ث','ق','ف','غ','ع','ه','خ','ح'],
    ['ش','س','ي','ب','ل','ا','ت','ن','م'],
    ['ئ','ء','ؤ','ر','لا','ى','ة','و','ز'],
  ];

  String _displayKey(String k) {
    if (isArabic) return k;
    if (!shift) return k;
    // shift for english letters
    if (k.length == 1 && RegExp(r'[a-z]').hasMatch(k)) return k.toUpperCase();
    return k;
  }

  String _valueKey(String k) {
    if (isArabic) return k;
    if (!shift) return k;
    if (k.length == 1 && RegExp(r'[a-z]').hasMatch(k)) return k.toUpperCase();
    return k;
  }


  @override
  Widget build(BuildContext context) {
    final layout = isArabic ? _arLayout : _enLayout;

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.controller.text, style: const TextStyle(color: Colors.white, fontSize: 22)),
            Row(
              children: [
                TvClick(
                  id: FocusKeys.kbLang,
                  leftId: FocusKeys.kbClear,
                  downId: FocusId.grid(FocusKeys.kb, 0, 0),
                  onSelect: () => setState(() => isArabic = !isArabic),
                  child: _chip(isArabic ? 'عربي' : 'EN'),
                ),
                const Spacer(),
                TvClick(
                  id: FocusKeys.kbClear,
                  rightId: FocusKeys.kbLang,
                  downId: FocusId.grid(FocusKeys.kb, 0, 0),
                  onSelect: _clear,
                  child: _chip('x'),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Key grid
            ...List.generate(layout.length, (r) {
              final rowKeys = layout[r];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(rowKeys.length, (c) {
                    final k = rowKeys[c];
                    final id = FocusId.grid(FocusKeys.kb, r, c);

                    // neighbor wiring (safe bounds)
                    String? left;
                    String? right;
                    String? up;
                    String? down;

                    if (c > 0) right = FocusId.grid(FocusKeys.kb, r, c - 1);
                    if (c < rowKeys.length - 1) {
                      left = FocusId.grid(FocusKeys.kb, r, c + 1);
                    }

                    // Up: header controls
                    if (r == 0) {
                      up = FocusKeys.kbLang; // go to header row
                    } else {
                      final prevRowLen = layout[r - 1].length;
                      final upCol = c.clamp(0, prevRowLen - 1);
                      up = FocusId.grid(FocusKeys.kb, r - 1, upCol);
                    }

                    // Down: next key row or action row (space/back/search)
                    if (r < layout.length - 1) {
                      final nextRowLen = layout[r + 1].length;
                      final downCol = c.clamp(0, nextRowLen - 1);
                      down = FocusId.grid(FocusKeys.kb, r + 1, downCol);
                    } else {
                      down = FocusKeys.kbBack;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: TvClick(
                        id: id,
                        leftId: left,
                        rightId: right,
                        upId: up,
                        downId: down,
                        radius: 10,
                        onSelect: () {
                          _insert(_valueKey(k));
                        },
                        child: _keyTile(_displayKey(k)),
                      ),
                    );
                  }),
                ),
              );
            }),

            // Action row: Space / Backspace / Search
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TvClick(
                  id: FocusKeys.kbBack,
                  leftId: FocusKeys.kbSpace,
                  upId: FocusId.grid(FocusKeys.kb, layout.length - 1, 0),
                  onSelect: _backspace,
                  child: _wideTile('⌫'),
                ),
                const SizedBox(width: 40),

                TvClick(
                  id: FocusKeys.kbSpace,
                  rightId: FocusKeys.kbBack,
                  leftId: 'kb.search',
                  upId: FocusId.grid(FocusKeys.kb, layout.length - 1, 0),
                  onSelect: () => _insert(' '),
                  child: _wideTile('SPACE', width: 300),
                ),
                const SizedBox(width: 40),

                TvClick(
                  id: 'kb.search',
                  rightId: FocusKeys.kbSpace,
                  upId: FocusId.grid(FocusKeys.kb, layout.length - 1, 0),
                  onSelect: widget.onSearch,
                  child: _wideTile(isArabic ? 'بحث' : 'SEARCH'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  Widget _keyTile(String text) {
    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _wideTile(String text,{double? width}) {
    return Container(
      width: width ?? 160,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white24, width: 2),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
