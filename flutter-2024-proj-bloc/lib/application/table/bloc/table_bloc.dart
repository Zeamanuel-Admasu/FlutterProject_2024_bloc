import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:flutter_application_1/infrastructure/Repository/table_respository.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TableEvent extends Equatable {
  const TableEvent();

  @override
  List<Object> get props => [];
}

class AddTable extends TableEvent {
  final String seats;
  final String type;
  final String floor;
  final String tableNum;

  AddTable({
    required this.seats,
    required this.type,
    required this.floor,
    required this.tableNum,
  });

  @override
  List<Object> get props => [seats, type, floor, tableNum];
}

class GetTable extends TableEvent {
  final String tableNum;

  GetTable({required this.tableNum});

  @override
  List<Object> get props => [tableNum];
}

class UpdateTable extends TableEvent {
  final String seats;
  final String type;
  final String floor;
  final String tableNum;

  UpdateTable({
    required this.seats,
    required this.type,
    required this.floor,
    required this.tableNum,
  });

  @override
  List<Object> get props => [seats, type, floor, tableNum];
}

class DeleteTable extends TableEvent {
  final String tableNum;

  DeleteTable({required this.tableNum});

  @override
  List<Object> get props => [tableNum];
}

// States
abstract class TableState extends Equatable {
  const TableState();

  @override
  List<Object> get props => [];
}

class TableInitial extends TableState {}

class TableLoading extends TableState {}

class TableSuccess extends TableState {
  final Map<String, String> table;

  TableSuccess({required this.table});

  @override
  List<Object> get props => [table];
}

class TableFailure extends TableState {
  final String error;

  TableFailure({required this.error});

  @override
  List<Object> get props => [error];
}

// Bloc
class TableBloc extends Bloc<TableEvent, TableState> {
  final TableService tableService;

  TableBloc({required this.tableService}) : super(TableInitial()) {
    on<AddTable>(_onAddTable);
    on<GetTable>(_onGetTable);
    on<UpdateTable>(_onUpdateTable);
    on<DeleteTable>(_onDeleteTable);
  }

  Future<void> _onAddTable(AddTable event, Emitter<TableState> emit) async {
    emit(TableLoading());
    try {
      final result = await tableService.table(
        event.type,
        event.floor,
        event.tableNum,
        event.seats,
        "create",
      );
      if (result.containsKey("error")) {
        emit(TableFailure(error: result["error"]!));
      } else {
        emit(TableSuccess(table: result));
      }
    } catch (error) {
      emit(TableFailure(error: error.toString()));
    }
  }

  Future<void> _onGetTable(GetTable event, Emitter<TableState> emit) async {
    emit(TableLoading());
    try {
      final result =
          await tableService.table("", "", event.tableNum, "", "read");
      if (result.containsKey("error")) {
        emit(TableFailure(error: result["error"]!));
      } else {
        emit(TableSuccess(table: result));
      }
    } catch (error) {
      emit(TableFailure(error: error.toString()));
    }
  }

  Future<void> _onUpdateTable(
    UpdateTable event,
    Emitter<TableState> emit,
  ) async {
    emit(TableLoading());
    try {
      final result = await tableService.table(
        event.seats,
        event.type,
        event.floor,
        event.tableNum,
        "update",
      );
      if (result.containsKey("error")) {
        emit(TableFailure(error: result["error"]!));
      } else {
        emit(TableSuccess(table: result));
      }
    } catch (error) {
      emit(TableFailure(error: error.toString()));
    }
  }

  Future<void> _onDeleteTable(
    DeleteTable event,
    Emitter<TableState> emit,
  ) async {
    emit(TableLoading());
    try {
      final result =
          await tableService.table("", "", event.tableNum, "", "delete");
      if (result.containsKey("error")) {
        emit(TableFailure(error: result["error"]!));
      } else {
        emit(TableSuccess(table: result));
      }
    } catch (error) {
      emit(TableFailure(error: error.toString()));
    }
  }
}
