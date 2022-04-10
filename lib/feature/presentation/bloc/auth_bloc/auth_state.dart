part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class UnAuthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {
  AuthenticatedState(this.userModel);

  final UserModel userModel;

  @override
  List<Object> get props => [userModel];
}
