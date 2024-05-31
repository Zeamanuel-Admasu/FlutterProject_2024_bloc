import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/type/type_bloc.dart';
import 'package:flutter_application_1/application/type/type_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeField extends StatelessWidget {
  final void Function(bool, String) onTypeSelected;

  const TypeField({
    required this.onTypeSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TypeBloc, TypeState>(
      builder: (context, state) {
        if (state is InitialTypeState) {
          return Wrap(
            children: <Widget>[
              ChoiceChip(
                key: const Key("typeChip"),
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Business',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                selected: state.val == 'Business',
                onSelected: (selected) {
                  if (selected) onTypeSelected(true, 'Business');
                },
                selectedColor: const Color.fromRGBO(0, 224, 231, 1),
                backgroundColor: const Color.fromRGBO(0, 147, 148, 1),
              ),
              const SizedBox(width: 10),
              ChoiceChip(
                label: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Non-Business',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                selected: state.val == 'Non-Business',
                onSelected: (selected) {
                  if (selected) onTypeSelected(true, 'Non-Business');
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
