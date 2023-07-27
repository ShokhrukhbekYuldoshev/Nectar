part of 'register_phone_bloc.dart';

abstract class RegisterPhoneEvent extends Equatable {
  const RegisterPhoneEvent();

  @override
  List<Object> get props => [];
}

class RegisterPhoneWithPhoneNumber extends RegisterPhoneEvent {
  final String phoneNumber;
  final Function(PhoneAuthCredential) onVerificationCompleted;
  final void Function(String, int?) onCodeSent;
  final Function(FirebaseAuthException)? onVerificationFailed;
  final Function(String)? onCodeAutoRetrievalTimeout;

  const RegisterPhoneWithPhoneNumber({
    required this.phoneNumber,
    required this.onVerificationCompleted,
    required this.onCodeSent,
    this.onVerificationFailed,
    this.onCodeAutoRetrievalTimeout,
  });

  @override
  List<Object> get props => [
        phoneNumber,
        onVerificationCompleted,
        onCodeSent,
        onVerificationFailed ?? (FirebaseAuthException e) {},
        onCodeAutoRetrievalTimeout ?? (String verificationId) {},
      ];
}

class VerifyPhoneWithCredential extends RegisterPhoneEvent {
  final PhoneAuthCredential credential;
  final void Function() onVerified;

  const VerifyPhoneWithCredential({
    required this.credential,
    required this.onVerified,
  });

  @override
  List<Object> get props => [credential, onVerified];
}
