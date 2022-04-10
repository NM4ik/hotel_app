import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hotel_ma/feature/data/models/user_model.dart';
import 'package:hotel_ma/feature/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(
          authenticationRepository.currentUser.isNotEmpty ? AuthenticatedState(authenticationRepository.currentUser) : UnAuthenticatedState(),
        ) {
    on<AuthUserChangedEvent>(_onUserChanged);
    on<AuthLogoutEvent>(_onLogoutRequested);
    _userSubscription = _authenticationRepository.userModel.listen(
      (user) {
        add(AuthUserChangedEvent(user));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<UserModel> _userSubscription;

  void _onUserChanged(AuthUserChangedEvent event, Emitter<AuthState> emit) {
    emit(
      event.userModel.isNotEmpty ? AuthenticatedState(event.userModel) : UnAuthenticatedState(),
    );
  }

  void _onLogoutRequested(AuthLogoutEvent event, Emitter<AuthState> emit) {
    _authenticationRepository.logOut();
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
