part of 'rooms_bloc.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();

  @override
  List<Object> get props => [];
}

class RoomsInitial extends RoomsState {
  @override
  List<Object> get props => [];
}

/// SIC = success internet connection
/// USIC = unsuccessful internet connection

class RoomsSICState extends RoomsState {
  final bool connection;

  const RoomsSICState({required this.connection});

  @override
  List<Object> get props => [bool];
}

class RoomsUSICState extends RoomsState {}

class RoomsEmptyState extends RoomsState {}

class RoomsLoadingState extends RoomsState {}

class RoomsLoadedState extends RoomsState {
  final List<RoomModel> rooms;

  const RoomsLoadedState({required this.rooms});

  @override
  List<Object> get props => [rooms];
}

class RoomsChooseState extends RoomsState {
  final RoomModel room;
  final DateTime firstDate;
  final DateTime lastDate;
  final List<String> tags;

  const RoomsChooseState({required this.room, required this.firstDate, required this.lastDate, required this.tags});

  @override
  List<Object> get props => [room, firstDate, lastDate];
}

class RoomsLoadingErrorState extends RoomsState {}
