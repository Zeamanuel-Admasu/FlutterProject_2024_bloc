import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/branch/branch_bloc.dart';
import 'package:flutter_application_1/application/branch/branch_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchField extends StatelessWidget {
  final void Function(bool, String) onBranchSelected;

  const BranchField({
    required this.onBranchSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BranchBloc, BranchState>(
      builder: (context, state) {
        if (state is InitialBranchState) {
          return Wrap(
            children: <Widget>[
              ChoiceChip(
                key: const Key("branchChip"),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Arat kilo',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                selected: state.branch == 'Arat kilo',
                onSelected: (selected) {
                  if (selected) onBranchSelected(true, 'Arat kilo');
                },
                selectedColor: const Color.fromRGBO(0, 224, 231, 1),
                backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
              ),
              const SizedBox(width: 7),
              ChoiceChip(
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Tor Hailoch',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                selected: state.branch == 'Tor Hailoch',
                onSelected: (selected) {
                  if (selected) onBranchSelected(true, "Tor Hailoch");
                },
                selectedColor: const Color.fromRGBO(0, 224, 231, 1),
                backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
              ),
              const SizedBox(width: 7),
              ChoiceChip(
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Mexico',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                selected: state.branch == 'Mexico',
                onSelected: (selected) {
                  if (selected) onBranchSelected(true, "Mexico");
                },
                selectedColor: const Color.fromRGBO(0, 224, 231, 1),
                backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
              ),
            ],
          );
        }
        return Container(); // Handle other states if needed
      },
    );
  }
}
