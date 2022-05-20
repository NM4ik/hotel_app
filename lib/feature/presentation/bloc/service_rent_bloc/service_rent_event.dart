part of 'service_rent_bloc.dart';

abstract class ServiceRentEvent extends Equatable {
  const ServiceRentEvent();

  @override
  List<Object> get props => [];
}

class ServiceRentLoadingEvent extends ServiceRentEvent {}

class ServiceRentChooseEvent extends ServiceRentEvent {
  final RentModel rent;
  final DateTime firstDate;
  final DateTime lastDate;

  const ServiceRentChooseEvent({required this.rent, required this.firstDate, required this.lastDate});

  @override
  List<Object> get props => [rent, firstDate, lastDate];
}
