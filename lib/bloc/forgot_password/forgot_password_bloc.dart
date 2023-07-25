import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:nectar/data/services/auth_service.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendResetPasswordLink>((event, emit) async {
      try {
        emit(ForgotPasswordLoading());
        await AuthService().sendPasswordResetEmail(
          event.email,
        );

        emit(
          const ForgotPasswordSuccess(
            message:
                'A password reset link has been sent to your email address.',
          ),
        );
      } catch (e, s) {
        debugPrint(e.toString());
        debugPrint(s.toString());
        emit(ForgotPasswordFailure(error: e.toString()));
      }
    });
  }
}
