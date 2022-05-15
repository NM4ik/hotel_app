import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitialState()) {
    on<BookingEvent>((event, emit) {
      on<StartBookingEvent>(_onBookingProcess);
      on<SuccessBookingEvent>(_onSuccessBookingEvent);
      on<ErrorBookingEvent>(_onErrorBookingEvent);
    });
  }

  void _onBookingProcess(StartBookingEvent event, Emitter<BookingState> emit) {
    emit(BookingLoadingState());
  }

  // FutureOr<void> _onStartBookingEvent(StartBookingEvent event, Emitter<BookingState> emit) {
  //     // emit(BookingLoadingState());
  //     // log('qweqweqwe', name: 'qweqwe');
  //     // emit(BookingProcessState(
  //     //     userModel: event.userModel, roomModel: event.roomModel, dateStart: event.dateStart, dateEnd: event.dateEnd, totalPrice: event.totalPrice));
  //   emit(BookingLoadingState());
  // }

  FutureOr<void> _onSuccessBookingEvent(SuccessBookingEvent event, Emitter<BookingState> emit) {
    // emit(BookingSuccessState(message: event.message));
    emit(BookingLoadingState());
  }

  FutureOr<void> _onErrorBookingEvent(ErrorBookingEvent event, Emitter<BookingState> emit) {
    emit(BookingErrorState(message: event.message));
  }


}
