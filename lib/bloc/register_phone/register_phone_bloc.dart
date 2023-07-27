import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:nectar/data/repositories/register_phone_repository.dart';

part 'register_phone_event.dart';
part 'register_phone_state.dart';

class RegisterPhoneBloc extends Bloc<RegisterPhoneEvent, RegisterPhoneState> {
  final registerPhoneRepository = RegisterPhoneRepository();
  RegisterPhoneBloc() : super(RegisterPhoneInitial()) {
    on<RegisterPhoneWithPhoneNumber>((event, emit) async {
      emit(RegisterPhoneLoading());
      try {
        await registerPhoneRepository.verifyPhoneNumber(
          phoneNumber: event.phoneNumber,
          onCodeSent: event.onCodeSent,
          onVerificationCompleted: event.onVerificationCompleted,
          onVerificationFailed: event.onVerificationFailed,
          onCodeAutoRetrievalTimeout: event.onCodeAutoRetrievalTimeout,
        );
        emit(RegisterPhoneSuccess());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RegisterPhoneFailure(error: e.toString()));
      }
    });

    on<VerifyPhoneWithCredential>((event, emit) async {
      emit(RegisterPhoneLoading());
      try {
        await registerPhoneRepository.signInWithCredential(event.credential);
        event.onVerified();
        emit(RegisterPhoneSuccess());
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(RegisterPhoneFailure(error: e.toString()));
      }
    });
  }
}
