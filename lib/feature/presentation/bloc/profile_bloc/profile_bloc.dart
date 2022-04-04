import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/locator_service.dart';
import '../../../../core/platform/network_info.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<ProfileAuthEvent>(_onProfileAuth);
  }

  FutureOr<void> _onProfileAuth(ProfileAuthEvent event, Emitter<ProfileState> emit) async {
    print('hello');
    emit(ProfileAuthenticatedState(bool: await locator.get<NetworkInfo>().getIsConnected()));
  }
}
