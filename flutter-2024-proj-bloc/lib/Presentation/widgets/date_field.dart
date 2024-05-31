import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final TextEditingController dateController;
  final bool isDateFocused;
  final bool isTimeFocused;

  const DateField({
    required this.dateController,
    required this.isDateFocused,
    required this.isTimeFocused,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        _selectDate(context);
      },
      controller: dateController,
      readOnly: true,
      style: TextStyle(
        color: isDateFocused ? Colors.white : Color.fromRGBO(159, 188, 204, 1),
        fontSize: isDateFocused ? 20 : 20,
      ),
      decoration: InputDecoration(
        labelText: 'Date',
        labelStyle: TextStyle(
          color:
              isDateFocused ? Colors.white : Color.fromRGBO(159, 188, 204, 1),
          fontSize: isDateFocused ? 24 : 23,
        ),
        prefixIcon: const Icon(
          Icons.date_range,
          color: Color.fromRGBO(245, 154, 123, 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
              color: Color.fromRGBO(159, 188, 204, 1), width: 1.8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue, width: 3),
        ),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null) {
      final formattedDate =
          '${picked.year}-${_twoDigits(picked.month)}-${_twoDigits(picked.day)}';
      dateController.text = formattedDate;
    }
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
