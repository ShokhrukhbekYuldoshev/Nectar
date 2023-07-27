part of 'register_phone_bloc.dart';

abstract class RegisterPhoneState extends Equatable {
  const RegisterPhoneState();

  @override
  List<Object> get props => [];
}

class RegisterPhoneInitial extends RegisterPhoneState {}

class RegisterPhoneLoading extends RegisterPhoneState {}

class RegisterPhoneSuccess extends RegisterPhoneState {}

class RegisterPhoneFailure extends RegisterPhoneState {
  final String error;

  const RegisterPhoneFailure({required this.error});

  @override
  List<Object> get props => [error];
}
