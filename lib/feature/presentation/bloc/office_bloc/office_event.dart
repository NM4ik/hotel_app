part of 'office_bloc.dart';

abstract class OfficeEvent extends Equatable {
  const OfficeEvent();

  @override
  List<Object> get props => [];
}

class OfficeCheckoutEvent extends OfficeEvent {}
