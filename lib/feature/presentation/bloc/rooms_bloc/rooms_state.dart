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
  final bool;

  const RoomsSICState({required this.bool});

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

class RoomsLoadingErrorState extends RoomsState {}
