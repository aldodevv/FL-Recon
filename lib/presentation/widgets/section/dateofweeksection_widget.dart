import 'package:flutter/material.dart';

class DateofweeksectionWidget extends StatefulWidget {
  final DateTime? initialDate;
  final Function(DateTime)? onDateSelected;
  
  const DateofweeksectionWidget({
    super.key,
    this.initialDate,
    this.onDateSelected,
  });

  @override
  State<DateofweeksectionWidget> createState() => _DateofweeksectionWidgetState();
}

class _DateofweeksectionWidgetState extends State<DateofweeksectionWidget> {
  late DateTime _currentDate;
  late DateTime _selectedWeekStart;
  
  static const List<String> _monthNames = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  
  static const List<String> _dayNames = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];
  
  @override
  void initState() {
    super.initState();
    _currentDate = widget.initialDate ?? DateTime.now();
    _selectedWeekStart = _getWeekStart(_currentDate);
  }

  DateTime _getWeekStart(DateTime date) {
    final weekday = date.weekday == 7 ? 0 : date.weekday;
    return DateTime(date.year, date.month, date.day - weekday);
  }

  List<DateTime> _getWeekDates() {
    return List.generate(7, (index) => 
      DateTime(_selectedWeekStart.year, _selectedWeekStart.month, _selectedWeekStart.day + index)
    );
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = _getWeekDates();
    final monthYear = '${_monthNames[weekDates[3].month - 1]} ${weekDates[3].year}';
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(monthYear),
          const SizedBox(height: 16),
          _buildWeekView(weekDates),
        ],
      ),
    );
  }

  Widget _buildHeader(String monthYear) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: _showMonthYearPicker,
          child: Text(
            monthYear,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildWeekView(List<DateTime> weekDates) {
    return Column(
      children: [
        // Day names row
        Row(
          children: List.generate(7, (index) {
            final isWeekend = index == 0 || index == 6;
            return Expanded(
              child: Center(
                child: Text(
                  _dayNames[index],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isWeekend ? Colors.red.shade400 : Colors.grey.shade700,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        // Dates row
        SizedBox(
          height: 44,
          child: Row(
            children: List.generate(7, (index) {
              final date = weekDates[index];
              final isSelected = _isSameDay(date, _currentDate);
              final isToday = _isSameDay(date, DateTime.now());
              final isWeekend = index == 0 || index == 6;
              
              return Expanded(
                child: _buildDayCell(date, isSelected, isToday, isWeekend),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCell(DateTime date, bool isSelected, bool isToday, bool isWeekend) {
    Color? backgroundColor;
    Color textColor = Colors.black87;
    
    if (isSelected) {
      backgroundColor = Colors.blue;
      textColor = Colors.white;
    } else if (isToday) {
      backgroundColor = Colors.blue.shade50;
      textColor = Colors.blue;
    }
    
    if (isWeekend && !isSelected) {
      textColor = Colors.red.shade400;
    }
    
    return GestureDetector(
      onTap: () => _onDateTap(date),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            date.day.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }

  void _onDateTap(DateTime date) {
    setState(() {
      _currentDate = date;
      _selectedWeekStart = _getWeekStart(date);
    });
    widget.onDateSelected?.call(date);
  }

  void _showMonthYearPicker() async {
    final result = await showDialog<DateTime>(
      context: context,
      builder: (context) => _MonthYearPickerDialog(
        initialDate: _currentDate,
      ),
    );
    
    if (result != null) {
      setState(() {
        _currentDate = result;
        _selectedWeekStart = _getWeekStart(result);
      });
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

class _MonthYearPickerDialog extends StatefulWidget {
  final DateTime initialDate;
  
  const _MonthYearPickerDialog({required this.initialDate});

  @override
  State<_MonthYearPickerDialog> createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<_MonthYearPickerDialog> {
  late int _selectedYear;
  late int _selectedMonth;
  
  static const List<String> _monthNames = [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.initialDate.year;
    _selectedMonth = widget.initialDate.month;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pilih Bulan & Tahun',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildYearSelector()),
                const SizedBox(width: 16),
                Expanded(child: _buildMonthSelector()),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(DateTime(_selectedYear, _selectedMonth, 1));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('OK'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearSelector() {
    final currentYear = DateTime.now().year;
    final years = List.generate(21, (index) => currentYear - 10 + index);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tahun', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: years.length,
            itemBuilder: (context, index) {
              final year = years[index];
              final isSelected = year == _selectedYear;
              
              return ListTile(
                dense: true,
                title: Text(
                  year.toString(),
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.blue : null,
                  ),
                ),
                selected: isSelected,
                onTap: () => setState(() => _selectedYear = year),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMonthSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Bulan', style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListView.builder(
            itemCount: 12,
            itemBuilder: (context, index) {
              final month = index + 1;
              final isSelected = month == _selectedMonth;
              
              return ListTile(
                dense: true,
                title: Text(
                  _monthNames[index],
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    color: isSelected ? Colors.blue : null,
                  ),
                ),
                selected: isSelected,
                onTap: () => setState(() => _selectedMonth = month),
              );
            },
          ),
        ),
      ],
    );
  }
}