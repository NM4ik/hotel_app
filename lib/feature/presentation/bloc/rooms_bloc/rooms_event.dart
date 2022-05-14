part of 'rooms_bloc.dart';

abstract class RoomsEvent extends Equatable {
  const RoomsEvent();
}

class RoomsCheckConnectionEvent extends RoomsEvent {
  @override
  List<Object> get props => [];
}

class RoomsLoadingEvent extends RoomsEvent {
  @override
  List<Object> get props => [];
}

class RoomsUpdateEvent extends RoomsEvent {
  final List<RoomModel> rooms;

  const RoomsUpdateEvent({required this.rooms});

  @override
  List<Object> get props => [rooms];
}

class RoomsChooseEvent extends RoomsEvent {
  final RoomModel room;
  final DateTime firstDate;
  final DateTime lastDate;

  const RoomsChooseEvent({required this.room, required this.firstDate, required this.lastDate});

  @override
  List<Object> get props => [room, firstDate, lastDate];
}
