import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/locator_service.dart';
import '../../../data/datasources/firestore_methods.dart';
import '../../../data/repositories/firestore_repository.dart';

part 'office_event.dart';

part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  OfficeBloc() : super(OfficeInitialState()) {
    on<OfficeRentEvent>(_onRoomsRentEvent);
    on<OfficeRoomEvent>(_onRoomsRoomsEvent);
  }

  // FirestoreRepository firestoreRepository = FirestoreRepository(firestoreMethods: locator.get<FirestoreMethods>());

  FutureOr<void> _onRoomsRentEvent(OfficeRentEvent event, Emitter<OfficeState> emit) async {
    List<String> someArray = [];

    emit(OfficeLoadingState());
    try {
      // final names = await FirebaseFirestore.instance.collection('office').doc('office').collection('names').get();
      // final categories = await FirebaseFirestore.instance.collection('rentCategory').get();
      // final categories = some.docs.map((e) => e.data()).toList();
      // final ids = categories.docs.map((e) => e.id).toList();
      //
      // log(ids.toString());
      // log(some.docs.map((e) => e.data()).toString(), name: "QWE");
      // log(categories[1]['title'].toString(), name: "QWE2");
      //
      // List<Map<String, dynamic>> rentCategories = [];
      // Map<String, dynamic> some = {};

      // ids.map((e) async {
      //   log(e.toString(), name: "IDS");
      //   final categories = await FirebaseFirestore.instance.collection('rentCategory').doc(e).get();
      //   log(categories.toString(), name: "CAT");
      //   final title = categories.data()!['title'];
      //   return log(title, name: "TITLE");
      // });
      // ids.map((e) async  {log(await FirebaseFirestore.instance.collection('rentCategory').doc(e).get().toString())});

      // names.docs.map((e) => someArray.add(e.id)).toList();

      emit(OfficeRoomState(names: someArray));
    } catch (e) {
      emit(OfficeErrorState(message: e.toString()));
    }
  }

  FutureOr<void> _onRoomsRoomsEvent(OfficeRoomEvent event, Emitter<OfficeState> emit) {}
}
