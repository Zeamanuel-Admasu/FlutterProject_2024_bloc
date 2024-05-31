import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class TokenEvent extends Equatable {
  const TokenEvent();

  @override
  List<Object> get props => [];
}

class SetToken extends TokenEvent {
  final String token;

  SetToken({required this.token});

  @override
  List<Object> get props => [token];
}

// States
abstract class TokenState extends Equatable {
  const TokenState();

  @override
  List<Object> get props => [];
}

class TokenInitial extends TokenState {}

class TokenUpdated extends TokenState {
  final String token;

  TokenUpdated({required this.token}) {
    print('Token updated: $token'); // Log the token update
  }

  @override
  List<Object> get props => [token];
}

// Bloc
class TokenBloc extends Bloc<TokenEvent, TokenState> {
  TokenBloc() : super(TokenInitial()) {
    on<SetToken>((event, emit) {
      emit(TokenUpdated(token: event.token));
    });
  }
}
