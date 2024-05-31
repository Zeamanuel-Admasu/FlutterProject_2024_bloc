import 'package:flutter/material.dart';
import 'number_of_people.dart';
import 'date_field.dart';
import 'type_field.dart';
import 'time_field.dart';
import 'branch_field.dart';

class ReservationForm extends StatefulWidget {
  final TextEditingController numberOfPeopleController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final String typeValue;
  final String branchValue;
  final bool isDateFocused;
  final bool isTimeFocused;
  final bool isGuestFocused;
  final void Function(bool, String) onTypeSelected;
  final void Function(bool, String) onBranchSelected;

  const ReservationForm({
    required this.numberOfPeopleController,
    required this.dateController,
    required this.timeController,
    required this.typeValue,
    required this.isDateFocused,
    required this.isTimeFocused,
    required this.isGuestFocused,
    required this.onTypeSelected,
    required this.branchValue,
    required this.onBranchSelected,
    Key? key,
  }) : super(key: key);
  @override
  _ReservationFormState createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  bool _isConfirming = false;

  @override
  Widget build(BuildContext context) {
    // when the widget runs make request to user
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
        child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            NumberOfPeopleField(
              numberOfPeopleController: widget.numberOfPeopleController,
              isGuestFocused: widget.isGuestFocused,
              isDateFocused: widget.isDateFocused,
              isTimeFocused: widget.isTimeFocused,
            ),
            const SizedBox(height: 25),
            DateField(
              dateController: widget.dateController,
              isDateFocused: widget.isDateFocused,
              isTimeFocused: widget.isTimeFocused,
            ),
            const SizedBox(height: 25),
            TimeField(
              timeController: widget.timeController,
              isDateFocused: widget.isDateFocused,
              isTimeFocused: widget.isTimeFocused,
            ),
            const SizedBox(height: 20),
            const Text(
              'Type',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 3),
            TypeField(
              typeValue: widget.typeValue,
              onTypeSelected: widget.onTypeSelected,
            ),
            const SizedBox(height: 10),
            const Text(
              'Branch',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 3),
            BranchField(
              branchValue: widget.branchValue,
              onBranchSelected: widget.onBranchSelected,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isConfirming = true;
                });
                Future.delayed(const Duration(seconds: 1), () {
                  setState(() {
                    _isConfirming = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            'Successfully Booked',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                      duration: Duration(seconds: 3),
                      backgroundColor: Colors.white,
                    ),
                  );
                });
              },
              child: _isConfirming
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    )
                  : const Text(
                      'Confirm Booking',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amberAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
