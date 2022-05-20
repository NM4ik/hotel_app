import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/rent_model.dart';

part 'service_rent_event.dart';

part 'service_rent_state.dart';

class ServiceRentBloc extends Bloc<ServiceRentEvent, ServiceRentState> {
  ServiceRentBloc() : super(ServiceRentInitial()) {
    on<ServiceRentChooseEvent>(_onServiceRentChooseEvent);
  }

  FutureOr<void> _onServiceRentChooseEvent(ServiceRentChooseEvent event, Emitter<ServiceRentState> emit) {
    emit(ServiceRentChooseState(rent: event.rent, firstDate: event.firstDate, lastDate: event.lastDate));
  }
}
