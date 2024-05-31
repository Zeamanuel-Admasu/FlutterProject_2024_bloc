import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/changeUsername/changeUsername_bloc.dart';
import 'package:flutter_application_1/application/changeUsername/changeUsername_event.dart';
import 'package:flutter_application_1/application/changeUsername/changeUsername_state.dart';
import 'package:flutter_application_1/application/token_bloc.dart';
import 'package:flutter_application_1/application/user/user_bloc.dart';
import 'package:flutter_application_1/infrastructure/Repository/changeUsername_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController changeUsernameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangeUsernameBloc(ChangeUsernameService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          leading: IconButton(
            key: const Key("backToProfile"),
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).replace("/home?index=3");
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: const Key("changeName"),
                controller: changeUsernameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 20),
              BlocConsumer<ChangeUsernameBloc, ChangeUsernameState>(
                listener: (context, state) {
                  if (state is ChangeUsernameSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                      duration: const Duration(seconds: 1),
                    ));
                  } else if (state is ChangeUsernameFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.error),
                      duration: const Duration(seconds: 1),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is ChangeUsernameLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ElevatedButton(
                    key: const Key("namechangeButton"),
                    onPressed: () {
                      final username = changeUsernameController.text;
                      context
                          .read<ChangeUsernameBloc>()
                          .add(ChangeUsernameRequested(username, context));
                    },
                    child: const Text('Save'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
