import 'package:flutter/material.dart';

class TimeField extends StatelessWidget {
  final TextEditingController timeController;
  final bool isDateFocused;
  final bool isTimeFocused;

  TimeField({
    required this.timeController,
    required this.isDateFocused,
    required this.isTimeFocused,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        _selectTime(context);
      },
      key: const Key("timeInput"),
      controller: timeController,
      readOnly: true,
      style: TextStyle(
        color: isTimeFocused ? Colors.white : Color.fromRGBO(159, 188, 204, 1),
        fontSize: isTimeFocused ? 20 : 20,
      ),
      decoration: InputDecoration(
        labelText: 'Time',
        labelStyle: TextStyle(
          color:
              isTimeFocused ? Colors.white : Color.fromRGBO(159, 188, 204, 1),
          fontSize: isTimeFocused ? 24 : 23,
        ),
        prefixIcon: const Icon(
          Icons.access_time,
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      timeController.text = picked.format(context);
    }
  }
}
