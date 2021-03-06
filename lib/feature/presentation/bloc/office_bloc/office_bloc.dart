import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/datasources/firestore_methods.dart';
import 'package:hotel_ma/feature/data/models/booking_model.dart';
import 'package:hotel_ma/feature/data/models/booking_status_model.dart';
import 'package:hotel_ma/feature/data/models/room_model.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';
import 'package:hotel_ma/feature/data/repositories/firestore_repository.dart';

import '../../../../core/locator_service.dart';
import '../../../data/models/room_type_model.dart';
import '../../../data/repositories/sql_repository.dart';

part 'office_event.dart';

part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  late final StreamSubscription<UserModel> _userSubscription;

  OfficeBloc() : super(OfficeInitialState()) {
    on<OfficeCheckoutEvent>(_onOfficeCheckStatusEvent);
  }

  FutureOr<void> _onOfficeCheckStatusEvent(OfficeCheckoutEvent event, Emitter<OfficeState> emit) async {
    final firebaseFirestore = FirebaseFirestore.instance;
    final firestoreRepository = FirestoreRepository(firestoreMethods: locator.get<FirestoreMethods>());

    emit(OfficeLoadingState());

    final user = locator.get<SqlRepository>().getUserFromSql();

    if (user == UserModel.empty) {
      emit(OfficeUnAuthState());
    } else {
      try {
        final map = await firebaseFirestore
            .collection("bookings")
            .where("status", isEqualTo: "active")
            .where("uid", isEqualTo: locator.get<SqlRepository>().getUserFromSql().uid)
            .get();

        final types = await firebaseFirestore.collection('roomTypes').get();
        final statuses = await firebaseFirestore.collection('bookingStatuses').get();

        if (map.docs.isNotEmpty) {
          final documentData = map.docs.single.data();
          final List<RoomTypeModel> roomTypesList = [];
          final List<BookingStatusModel> bookingStatusList = [];

          types.docs.map((e) => roomTypesList.add(RoomTypeModel.fromJson(e.data(), e.id))).toList();
          statuses.docs.map((e) => bookingStatusList.add(BookingStatusModel.fromJson(e.data(), e.id))).toList();

          final bookingId = map.docs.single.id;
          final uid = documentData['uid'];
          final roomId = documentData['roomId'];

          final room = await firestoreRepository.getRoom(roomId);

          final booking = BookingModel.fromJson(documentData, roomTypesList, bookingStatusList, bookingId);

          room == null
              ? emit(const OfficeErrorState(message: "?????????????? ??????..."))
              : emit(OfficeLiveState(bookingId: bookingId, uid: uid, roomModel: room, bookingModel: booking));
        } else {
          emit(OfficeUnLiveState());
        }
      } catch (e) {
        emit(OfficeErrorState(message: e.toString()));
      }
    }
  }
}
