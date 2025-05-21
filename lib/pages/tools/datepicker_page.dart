import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

@RoutePage()
class DatePickerPage extends StatelessWidget {
  const DatePickerPage({super.key});

  Future<void> _showDateDialog(BuildContext context) async {
    final date = await showDatePickerDialog(
      context: context,
      minDate: DateTime(2021, 1, 1),
      maxDate: DateTime(2023, 12, 31),
    );
    if (date != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tanggal dipilih: $date')),
      );
    }
  }

  Future<void> _showRangeDialog(BuildContext context) async {
    final range = await showRangePickerDialog(
      context: context,
      minDate: DateTime(2021, 1, 1),
      maxDate: DateTime(2023, 12, 31),
    );
    if (range != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Rentang: ${range.start} - ${range.end}')),
      );
    }
  }

  void _showCustomDialog(BuildContext context, Widget child) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: SizedBox(width: 300, height: 400, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Date Picker Plus Demo")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () => _showDateDialog(context),
            child: const Text('Show Date Picker Dialog'),
          ),
          ElevatedButton(
            onPressed: () => _showRangeDialog(context),
            child: const Text('Show Range Picker Dialog'),
          ),
          ElevatedButton(
            onPressed: () => _showCustomDialog(
              context,
              DatePicker(
                minDate: DateTime(2021, 1, 1),
                maxDate: DateTime(2023, 12, 31),
                onDateSelected: (value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('DatePicker: $value')),
                  );
                },
              ),
            ),
            child: const Text('Show DatePicker Widget'),
          ),
          ElevatedButton(
            onPressed: () => _showCustomDialog(
              context,
              RangeDatePicker(
                minDate: DateTime(2020, 10, 10),
                maxDate: DateTime(2024, 10, 30),
                onRangeSelected: (value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Range: ${value.start} - ${value.end}')),
                  );
                },
              ),
            ),
            child: const Text('Show RangeDatePicker Widget'),
          ),
          ElevatedButton(
            onPressed: () => _showCustomDialog(
              context,
              DaysPicker(
                minDate: DateTime(2021, 1, 1),
                maxDate: DateTime(2023, 12, 31),
                onDateSelected: (value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('DaysPicker: $value')),
                  );
                },
              ),
            ),
            child: const Text('Show DaysPicker Widget'),
          ),
          ElevatedButton(
            onPressed: () => _showCustomDialog(
              context,
              MonthPicker(
                minDate: DateTime(2021, 1),
                maxDate: DateTime(2023, 12),
                onDateSelected: (value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('MonthPicker: $value')),
                  );
                },
              ),
            ),
            child: const Text('Show MonthPicker Widget'),
          ),
          ElevatedButton(
            onPressed: () => _showCustomDialog(
              context,
              YearsPicker(
                minDate: DateTime(2021),
                maxDate: DateTime(2023),
                onDateSelected: (value) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('YearsPicker: $value')),
                  );
                },
              ),
            ),
            child: const Text('Show YearsPicker Widget'),
          ),
        ],
      ),
    );
  }
}
