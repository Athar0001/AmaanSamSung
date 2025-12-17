import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:amaan_tv/core/widget/Text%20Field/text_field_widget.dart';

import '../../Themes/app_colors_new.dart';

class DatePickerTextField extends StatefulWidget {
  const DatePickerTextField(
      {required this.dateController, super.key, this.onChange});

  final TextEditingController dateController;
  final void Function(DateTime date)? onChange;

  @override
  DatePickerTextFieldState createState() => DatePickerTextFieldState();
}

class DatePickerTextFieldState extends State<DatePickerTextField> {
  Future<void> _selectDate(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      widget.onChange?.call(pickedDate);
      final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      setState(() {
        widget.dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: TextFieldWidget(
        // color: AppColors.primaryLight2,
        controller: widget.dateController,
        hintText: 'Enter ',
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your date';
          }
          return null;
        },
        ontap: () {
          _selectDate(context);
        },
        suffixIcon: const Icon(
          Icons.keyboard_arrow_down_sharp,
          color: AppColorsNew.primary,
        ),
        readOnly: true,
      ),
    );
  }
}
