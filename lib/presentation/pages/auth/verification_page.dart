import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import 'package:nectar/bloc/register_phone/register_phone_bloc.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/assets.dart';

class VerificationPage extends StatefulWidget {
  final String verificationId;
  const VerificationPage({super.key, required this.verificationId});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              PngAssets.mask,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 30,
              left: 25,
              right: 25,
              bottom: 90,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // back button
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // text
                const Text(
                  'Enter your verification code',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                // otp field
                Pinput(
                  length: 6,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  controller: otpController,
                  onCompleted: (otp) {
                    // Verify otp
                    context.read<RegisterPhoneBloc>().add(
                          VerifyPhoneWithCredential(
                            credential: PhoneAuthProvider.credential(
                              verificationId: widget.verificationId,
                              smsCode: otp,
                            ),
                            onVerified: () {
                              // Navigate to select location page
                              Navigator.pushNamed(
                                context,
                                AppRouter.selectLocationRoute,
                              );
                            },
                          ),
                        );
                  },
                ),
                const SizedBox(height: 30),
                // resend otp
                Row(
                  children: [
                    const Text(
                      'Didn\'t receive the code?',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Resend verification code
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
