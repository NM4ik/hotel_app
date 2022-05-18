part of 'office_bloc.dart';

abstract class OfficeState extends Equatable {
  const OfficeState();

  @override
  List<Object> get props => [];
}

class OfficeInitialState extends OfficeState {}

class OfficeLoadingState extends OfficeState {}

class OfficeRoomState extends OfficeState {
  final List<String> names;

  const OfficeRoomState({required this.names});

  @override
  List<Object> get props => [names];
}

class OfficeRentState extends OfficeState {
  final List<String> rents;

  const OfficeRentState({required this.rents});

  @override
  List<Object> get props => [rents];
}

class OfficeErrorState extends OfficeState {
  final String message;

  const OfficeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
