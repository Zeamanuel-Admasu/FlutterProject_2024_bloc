import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/branch/branch_bloc.dart';
import 'package:flutter_application_1/application/branch/branch_event.dart';
import 'package:flutter_application_1/application/type/type_bloc.dart';
import 'package:flutter_application_1/application/type/type_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import './reserve.dart';

class ReservationFormPage extends StatefulWidget {
  final String data;
  final bool create;
  final String tableNumber;
  final String checkTime;

  ReservationFormPage(
      {Key? key,
      required this.checkTime,
      required this.data,
      required this.create,
      required this.tableNumber})
      : super(key: key);

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
          leading: IconButton(
            key: const Key("backToHomeFromReserve"),
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).replace("/home?index=1");
            },
          ),
        ),
        backgroundColor: const Color.fromRGBO(8, 68, 104, 1),
        body: ReservationForm(
          checkTime: widget.checkTime,
          tableNumber: widget.tableNumber,
          create: widget.create,
          foodName: widget.data,
          numberOfPeopleController: _numberOfPeopleController,
          dateController: _dateController,
          timeController: _timeController,
          isDateFocused: _isDateFocused,
          isTimeFocused: _isTimeFocused,
          onTypeSelected: (selected, selectedType) {
            if (selected) {
              context.read<TypeBloc>().add(UpdateTypeEvent(selectedType));
            } else {
              context.read<TypeBloc>().add(UpdateTypeEvent(""));
            }
          },
          onBranchSelected: (selected, selectedBranch) {
            if (selected) {
              context.read<BranchBloc>().add(UpdateBranchEvent(selectedBranch));
            } else {
              context.read<BranchBloc>().add(UpdateBranchEvent(""));
            }
          },
        ));
  }
}
