import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';

import '../../../../core/locator_service.dart';
import '../../../data/repositories/sql_repository.dart';

part 'office_event.dart';

part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  OfficeBloc() : super(OfficeInitialState()) {
    on<OfficeCheckStatusEvent>(_onOfficeCheckStatusEvent);
  }

  FutureOr<void> _onOfficeCheckStatusEvent(OfficeCheckStatusEvent event, Emitter<OfficeState> emit) async {
    emit(OfficeLoadingState());

    final user = locator.get<SqlRepository>().getUserFromSql();

    if (user == UserModel.empty) {
      emit(OfficeUnAuthState());
    } else {
      try {
        final map = await FirebaseFirestore.instance
            .collection('bookings')
            .where("status", isEqualTo: "active")
            .where("uid", isEqualTo: locator.get<SqlRepository>().getUserFromSql().uid)
            .get();

        if (map.docs.isNotEmpty) {
          final documentData = map.docs.single.data();

          final bookingId = map.docs.single.id;
          final uid = documentData['uid'];

          emit(OfficeLiveState(bookingId: bookingId, uid: uid));
          log(documentData.toString());
        } else {
          emit(OfficeUnLiveState());
        }
      } catch (e) {
        emit(OfficeErrorState());
      }
    }
  }
}
