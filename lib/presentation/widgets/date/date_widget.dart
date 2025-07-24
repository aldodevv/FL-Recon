import 'package:date_picker_plus/date_picker_plus.dart' as picker;
import 'package:flutter/material.dart';
import 'package:recon/core/constants/colors_const.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return picker.DatePicker(
      maxDate: DateTime.now().add(const Duration(days: 365)),
      minDate: DateTime.now().subtract(const Duration(days: 365)),
      onDateSelected: (date) {
        // Your logic here
      },
      initialDate: DateTime.now(),
      selectedDate: DateTime.now(),
      currentDate: DateTime.now(),
      padding: const EdgeInsets.all(16),
      initialPickerType: picker.PickerType.days,
      daysOfTheWeekTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(30),
            fontWeight: FontWeight.bold,
          ),
      enabledCellsTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onSurface,
          ),
      enabledCellsDecoration: const BoxDecoration(),
      disabledCellsTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(30),
          ),
      disabledCellsDecoration: const BoxDecoration(),
      currentDateTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.primary,
          ),
      currentDateDecoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        shape: BoxShape.circle,
      ),
      selectedCellTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
      selectedCellDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        shape: BoxShape.circle,
      ),
      leadingDateTextStyle: TextStyle(
        fontSize: 18, 
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
      slidersColor: Theme.of(context).colorScheme.primary,
      slidersSize: 20,
      highlightColor:
          Theme.of(context).colorScheme.primary.withAlpha(10),
      splashColor: Theme.of(context).colorScheme.primary.withAlpha(20),
      splashRadius: 24,
      centerLeadingDate: false,
      previousPageSemanticLabel: 'Previous Month',
      nextPageSemanticLabel: 'Next Month',
      weekendTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.normal,
            color: MainColors.blue50,
          )
    );
  }
}