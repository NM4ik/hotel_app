part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileAuthenticatedState  extends ProfileState {
  final bool;

  ProfileAuthenticatedState({required this.bool});

  @override
  List<Object> get props => [bool];
}

class ProfileUnAuthenticatedState  extends ProfileState {
  @override
  List<Object> get props => [];
}