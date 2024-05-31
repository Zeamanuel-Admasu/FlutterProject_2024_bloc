import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  final Function(DateTime?) onDateSelected;

  const DatePickerWidget({Key? key, required this.onDateSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: const Text('Search by Date'),
      onTap: () async {
        final DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2101),
        );
        onDateSelected(pickedDate);
      },
    );
  }
}
