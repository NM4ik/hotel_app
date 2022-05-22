import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'office_event.dart';
part 'office_state.dart';

class OfficeBloc extends Bloc<OfficeEvent, OfficeState> {
  OfficeBloc() : super(OfficeInitialState()) {
    on<OfficeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
