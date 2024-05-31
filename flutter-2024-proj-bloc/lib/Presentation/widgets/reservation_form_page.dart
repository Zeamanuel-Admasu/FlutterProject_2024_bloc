import 'package:flutter/material.dart';
import './reserve.dart';

class ReservationFormPage extends StatefulWidget {
  const ReservationFormPage({Key? key}) : super(key: key);

  @override
  _ReservationFormPageState createState() => _ReservationFormPageState();
}

class _ReservationFormPageState extends State<ReservationFormPage> {
  final TextEditingController _numberOfPeopleController =
      TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _typeValue = '';
  String _branchValue = '';
  bool _isDateFocused = false;
  bool _isTimeFocused = false;
  bool _isGuestFocused = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Reservation Form'),
        ),
        backgroundColor: const Color.fromRGBO(8, 68, 104, 1),
        body: ReservationForm(
          numberOfPeopleController: _numberOfPeopleController,
          dateController: _dateController,
          timeController: _timeController,
          typeValue: _typeValue,
          branchValue: _branchValue,
          isDateFocused: _isDateFocused,
          isTimeFocused: _isTimeFocused,
          isGuestFocused: _isGuestFocused,
          onTypeSelected: (selected, selectedType) {
            setState(() {
              _typeValue = selected ? selectedType : '';
            });
          },
          onBranchSelected: (selected, selectedBranch) {
            setState(() {
              _branchValue = selected ? selectedBranch : '';
            });
          },
        ));
  }
}
