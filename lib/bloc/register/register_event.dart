part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterWithEmailAndPassword extends RegisterEvent {
  final String email;
  final String password;

  const RegisterWithEmailAndPassword({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class RegisterWithGoogle extends RegisterEvent {}

class RegisterWithFacebook extends RegisterEvent {}
