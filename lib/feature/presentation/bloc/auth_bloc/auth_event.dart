part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthLogoutEvent extends AuthEvent {}

class AuthUserChangedEvent extends AuthEvent {
  AuthUserChangedEvent(this.userModel);

  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}
