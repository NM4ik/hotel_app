part of 'service_rent_bloc.dart';

abstract class ServiceRentState extends Equatable {
  const ServiceRentState();

  @override
  List<Object> get props => [];
}

class ServiceRentInitial extends ServiceRentState {}

class ServiceRentLoadingState extends ServiceRentState {}

class ServiceRentChooseState extends ServiceRentState {
  final RentModel rent;
  final DateTime firstDate;
  final DateTime lastDate;

  const ServiceRentChooseState({required this.rent, required this.firstDate, required this.lastDate});

  @override
  List<Object> get props => [rent, firstDate, lastDate];
}

class ServiceRentErrorState extends ServiceRentState {}
