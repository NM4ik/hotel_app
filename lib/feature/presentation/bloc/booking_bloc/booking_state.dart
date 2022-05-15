part of 'booking_bloc.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitialState extends BookingState {}

class BookingLoadingState extends BookingState {}

class BookingProcessState extends BookingState {
  final UserModel userModel;
  final RoomModel roomModel;
  final DateTime dateStart;
  final DateTime dateEnd;
  final String totalPrice;

  const BookingProcessState({required this.userModel, required this.roomModel, required this.dateStart, required this.dateEnd, required this.totalPrice});

  @override
  List<Object> get props =>
      [
        userModel,
        roomModel,
        dateStart,
        dateEnd,
        totalPrice,
      ];
}

class BookingSuccessState extends BookingState {
  final String message;

  const BookingSuccessState({required this.message});

  @override
  List<Object> get props => [message];
}

class BookingErrorState extends BookingState {
  final String message;

  const BookingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
