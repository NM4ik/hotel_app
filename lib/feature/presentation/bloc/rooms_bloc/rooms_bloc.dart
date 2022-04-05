import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/core/platform/network_info.dart';

import '../../../../core/locator_service.dart';

part 'rooms_event.dart';

part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc() : super(RoomsInitial()) {
    on<RoomsCheckConnectionEvent>(_onRoomsStatus);
  }

  FutureOr<void> _onRoomsStatus(RoomsCheckConnectionEvent event, Emitter<RoomsState> emit) async{
    if(await locator.get<NetworkInfo>().getIsConnected() == true){
      emit(const RoomsSICState(bool: true));
    } else {
    emit(RoomsUSICState());
    }
  }
}
