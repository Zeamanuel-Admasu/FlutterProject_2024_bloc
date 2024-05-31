import 'package:flutter_application_1/application/changeUsername/changeUsername_event.dart';
import 'package:flutter_application_1/application/changeUsername/changeUsername_state.dart';
import 'package:flutter_application_1/infrastructure/Repository/changeUsername_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeUsernameBloc
    extends Bloc<ChangeUsernameEvent, ChangeUsernameState> {
  final ChangeUsernameService changeUsernameService;

  ChangeUsernameBloc(this.changeUsernameService)
      : super(ChangeUsernameInitial()) {
    on<ChangeUsernameRequested>((event, emit) async {
      emit(ChangeUsernameLoading());
      try {
        final message = await changeUsernameService.changeUsername(
            event.username, event.context);
        emit(ChangeUsernameSuccess(message));
      } catch (e) {
        emit(ChangeUsernameFailure(e.toString()));
      }
    });
  }
}
