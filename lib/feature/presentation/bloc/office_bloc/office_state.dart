part of 'office_bloc.dart';

abstract class OfficeState extends Equatable {
  const OfficeState();

  @override
  List<Object> get props => [];
}

class OfficeInitialState extends OfficeState {}

class OfficeLoadingState extends OfficeState {}

class OfficeLiveState extends OfficeState {
  final String bookingId;
  final String uid;
  final RoomModel roomModel;
  final BookingModel bookingModel;

  const OfficeLiveState({required this.bookingId, required this.uid, required this.roomModel, required this.bookingModel});

  @override
  List<Object> get props => [bookingId, uid];
}

class OfficeUnAuthState extends OfficeState {}

class OfficeUnLiveState extends OfficeState {}

class OfficeErrorState extends OfficeState {
  final String message;

  const OfficeErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
