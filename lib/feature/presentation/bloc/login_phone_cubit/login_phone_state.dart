part of 'login_phone_cubit.dart';

abstract class LoginPhoneState extends Equatable {
  const LoginPhoneState();

  @override
  List<Object> get props => [];
}

class LoginPhoneInitialState extends LoginPhoneState {}

class LoginPhoneLoadingState extends LoginPhoneState {}

class LoginPhoneCodeSentState extends LoginPhoneState {}

class LoginCodeVerifiedState extends LoginPhoneState {}

class LoginPhoneLoggedInState extends LoginPhoneState {}

class LoginPhoneErrorState extends LoginPhoneState {
  final String message;

  const LoginPhoneErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class LoginPhoneFirstState extends LoginPhoneState {
  final UserModel user;

  const LoginPhoneFirstState({required this.user});

  List<Object> get props => [user];
}
