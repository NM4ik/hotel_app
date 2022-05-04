part of 'login_phone_cubit.dart';

abstract class LoginPhoneState {
  const LoginPhoneState();
}

class LoginPhoneInitialState extends LoginPhoneState {}

class LoginPhoneLoadingState extends LoginPhoneState {}

class LoginPhoneCodeSentState extends LoginPhoneState {}

class LoginCodeVerifiedState extends LoginPhoneState {}

class LoginPhoneLoggedInState extends LoginPhoneState {}

class LoginPhoneErrorState extends LoginPhoneState {
  final String message;

  const LoginPhoneErrorState({required this.message});
}
