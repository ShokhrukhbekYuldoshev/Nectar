part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLogoutSuccess extends AccountState {}

class AccountLogoutFailure extends AccountState {
  final String message;

  const AccountLogoutFailure(this.message);

  @override
  List<Object> get props => [message];
}
