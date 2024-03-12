import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:nectar/src/data/services/auth_service.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountLogout>((event, emit) async {
      try {
        emit(AccountLoading());
        AuthService().signOut();
        await Hive.box('myBox').delete('user');
        emit(AccountLogoutSuccess());
      } catch (e, s) {
        debugPrintStack(label: e.toString(), stackTrace: s);
        emit(AccountLogoutFailure(e.toString()));
      }
    });
  }
}
