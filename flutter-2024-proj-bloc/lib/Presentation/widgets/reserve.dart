import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/branch/branch_bloc.dart';
import 'package:flutter_application_1/application/branch/branch_state.dart';
import 'package:flutter_application_1/application/reservation/reservation_bloc.dart';
import 'package:flutter_application_1/application/reservation/reservation_event.dart';
import 'package:flutter_application_1/application/reservation/reservation_state.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/application/type/type_bloc.dart';
import 'package:flutter_application_1/application/type/type_event.dart';
import 'package:flutter_application_1/application/type/type_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'number_of_people.dart';
import 'date_field.dart';
import 'type_field.dart';
import 'time_field.dart';
import 'branch_field.dart';

class ReservationForm extends StatelessWidget {
  final bool create;
  final String tableNumber;
  final String checkTime;
  final String foodName;
  final TextEditingController numberOfPeopleController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final bool isDateFocused;
  final bool isTimeFocused;
  final void Function(bool, String) onTypeSelected;
  final void Function(bool, String) onBranchSelected;

  ReservationForm({
    required this.checkTime,
    required this.tableNumber,
    required this.create,
    required this.foodName,
    required this.numberOfPeopleController,
    required this.dateController,
    required this.timeController,
    required this.isDateFocused,
    required this.isTimeFocused,
    required this.onTypeSelected,
    required this.onBranchSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReserveBloc, ReserveState>(
      listener: (context, state) {
        if (state is ReserveFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
            duration: const Duration(seconds: 5),
          ));
        } else if (state is ReserveSuccess) {
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
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 15),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NumberOfPeopleField(
                    numberOfPeopleController: numberOfPeopleController,
                  ),
                  const SizedBox(height: 25),
                  DateField(
                    dateController: dateController,
                    isDateFocused: isDateFocused,
                    isTimeFocused: isTimeFocused,
                  ),
                  const SizedBox(height: 25),
                  TimeField(
                    timeController: timeController,
                    isDateFocused: isDateFocused,
                    isTimeFocused: isTimeFocused,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Type',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(height: 3),
                  TypeField(
                    onTypeSelected: onTypeSelected,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Branch',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  const SizedBox(height: 3),
                  BranchField(
                    onBranchSelected: onBranchSelected,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    key: const Key("confirmBooking"),
                    onPressed: state is! ReserveLoading
                        ? () {
                            final reserveBloc =
                                BlocProvider.of<ReserveBloc>(context);
                            final tokenState =
                                BlocProvider.of<TokenBloc>(context).state;
                            String token = '';
                            if (tokenState is TokenUpdated) {
                              token = tokenState.token;
                            }

                            final selectedType = context.read<TypeBloc>().state
                                    is InitialTypeState
                                ? (context.read<TypeBloc>().state
                                        as InitialTypeState)
                                    .val
                                : '';
                            final selectedBranch = context
                                    .read<BranchBloc>()
                                    .state is InitialBranchState
                                ? (context.read<BranchBloc>().state
                                        as InitialBranchState)
                                    .branch
                                : ''; // Replace with actual token retrieval logic
                            if (create) {
                              reserveBloc.add(CreateReservation(
                                token: token,
                                seatsH: numberOfPeopleController.text,
                                date: dateController.text,
                                time: timeController.text,
                                typeH:
                                    selectedType, // Replace with actual type value
                                branch:
                                    selectedBranch, // Replace with actual branch value
                                foodName: foodName,
                                tableNumber: tableNumber,
                                checkTime: checkTime,
                              ));
                            } else {
                              reserveBloc.add(UpdateReservation(
                                token: token,
                                seatsH: numberOfPeopleController.text,
                                date: dateController.text,
                                time: timeController.text,
                                typeH:
                                    selectedType, // Replace with actual type value
                                branch:
                                    selectedBranch, // Replace with actual branch value
                                foodName: foodName,
                                tableNumber: tableNumber,
                                checkTime: checkTime,
                              ));
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amberAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: state is ReserveLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                            ),
                          )
                        : const Text(
                            'Confirm Booking',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
