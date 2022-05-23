part of 'office_bloc.dart';

abstract class OfficeState extends Equatable {
  const OfficeState();

  @override
  List<Object> get props => [];
}

class OfficeInitialState extends OfficeState {}

class OfficeLoadingState extends OfficeState {}

class OfficeLiveState extends OfficeState {
  final String bookingId;
  final String uid;

  const OfficeLiveState({required this.bookingId, required this.uid});

  @override
  List<Object> get props => [bookingId, uid];
}

class OfficeUnAuthState extends OfficeState{}

class OfficeUnLiveState extends OfficeState {}

class OfficeErrorState extends OfficeState {}
