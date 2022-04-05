part of 'rooms_bloc.dart';

abstract class RoomsState extends Equatable {
  const RoomsState();
}

class RoomsInitial extends RoomsState {
  @override
  List<Object> get props => [];
}

/// SIC = success internet connection
/// USIC = unsuccessful internet connection


class RoomsSICState  extends RoomsState {
  final bool;

  const RoomsSICState({required this.bool});

  @override
  List<Object> get props => [bool];
}

class RoomsUSICState  extends RoomsState {
  @override
  List<Object> get props => [];
}