import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotel_ma/core/platform/network_info.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';

import '../../../../core/locator_service.dart';

part 'rooms_event.dart';

part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc() : super(RoomsInitial()) {
    on<RoomsCheckConnectionEvent>(_onRoomsStatus);
    on<RoomsLoadingEvent>(_onRoomsLoading);
    on<RoomsUpdateEvent>(_onRoomsUpdateEvent);
    on<RoomsChooseEvent>(_onRoomsChooseEvent);
  }

  FirestoreRepository firestoreRepository = FirestoreRepository(firestoreMethods: locator.get<FirestoreMethods>());

  FutureOr<void> _onRoomsStatus(RoomsCheckConnectionEvent event, Emitter<RoomsState> emit) async =>
      await locator.get<NetworkInfo>().getIsConnected() == true ? add(RoomsLoadingEvent()) : emit(RoomsUSICState());

  FutureOr<void> _onRoomsLoading(dynamic event, Emitter<RoomsState> emit) async {
    try {
      List<RoomModel>? rooms = [];
      emit(RoomsLoadingState());

      rooms = await firestoreRepository.getRooms();

      rooms!.isEmpty ? emit(RoomsEmptyState()) : emit(RoomsLoadedState(rooms: rooms));
    } catch (e) {
      log('$e', name: '_onRoomsLoadingException');
      emit(RoomsLoadingErrorState());
    }
  }

  FutureOr<void> _onRoomsUpdateEvent(RoomsUpdateEvent event, Emitter<RoomsState> emit) {
    emit(RoomsLoadingState());
    emit(RoomsLoadedState(rooms: event.rooms));
  }

  FutureOr<void> _onRoomsChooseEvent(RoomsChooseEvent event, Emitter<RoomsState> emit) async {
    try {
      final List<String> tags = [];
      if (event.room.tags!.isNotEmpty) {
        final response = await FirebaseFirestore.instance.collection('roomTags').where(FieldPath.documentId, whereIn: event.room.tags).get();
        log(response.docs.toString());
        // print(response.docs.map((e) => e.data().toString()));
        response.docs.map((e) => tags.add(e['title'])).toList();
        log(tags.toString(), name: "TAGS");
      }

      emit(RoomsChooseState(room: event.room, firstDate: event.firstDate, lastDate: event.lastDate, tags: tags));
    } catch (e) {
      log(e.toString(), name: "_onRoomsChoseEventException");
      emit(RoomsLoadingErrorState());
    }
  }
}
