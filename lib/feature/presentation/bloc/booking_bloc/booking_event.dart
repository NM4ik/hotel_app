part of 'booking_bloc.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();
}

class StartBookingEvent extends BookingEvent {
  final UserModel userModel;
  final RoomModel roomModel;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String totalPrice;

  const StartBookingEvent({required this.userModel, required this.roomModel, required this.dateStart, required this.dateEnd, required this.totalPrice});

  @override
  List<Object> get props => [
        userModel,
        roomModel,
        dateStart,
        dateEnd,
        totalPrice,
      ];
}

class SuccessBookingEvent extends BookingEvent {
  final String message;

  const SuccessBookingEvent({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorBookingEvent extends BookingEvent {
  final String message;

  const ErrorBookingEvent({required this.message});

  @override
  List<Object> get props => [message];
}
