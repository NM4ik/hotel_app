import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_data.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';

import '../../../../core/locator_service.dart';

part 'rooms_event.dart';

part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc() : super(RoomsInitial()) {
    on<RoomsCheckConnectionEvent>(_onRoomsStatus);
    on<RoomsLoadingEvent>(_onRoomsLoading);
  }

  FirestoreRepository firestoreRepository = FirestoreRepository(firestoreData: locator.get<FirestoreData>());

  FutureOr<void> _onRoomsStatus(RoomsCheckConnectionEvent event, Emitter<RoomsState> emit) async =>
      await locator.get<NetworkInfo>().getIsConnected() == true ? add(RoomsLoadingEvent()) : emit(RoomsUSICState());

  FutureOr<void> _onRoomsLoading(dynamic event, Emitter<RoomsState> emit) async{
    try {
      List<RoomModel>? rooms = [];
      emit(RoomsLoadingState());

      rooms = await firestoreRepository.getRooms();

      rooms!.isEmpty ? emit(RoomsEmptyState()) : emit(RoomsLoadedState(rooms: rooms));
    } catch (e) {
      log('$e', name: 'Expcetion by _onRoomsLoading');
      emit(RoomsLoadingErrorState());
    }
  }
}
