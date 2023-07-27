import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:nectar/bloc/register_phone/register_phone_bloc.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/widgets/buttons/next_fab.dart';
import 'package:nectar/data/models/user.dart' as model;

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({super.key});

  @override
  State<RegisterPhonePage> createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  final TextEditingController phoneController = TextEditingController(
    text: Hive.box('myBox').get('phone', defaultValue: ''),
  );

  String countryCode = "+1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NextFab(
        onPressed: () {
          context.read<RegisterPhoneBloc>().add(
                RegisterPhoneWithPhoneNumber(
                  phoneNumber: countryCode + phoneController.text,
                  onVerificationCompleted: (PhoneAuthCredential credential) {},
                  onCodeSent: (String verificationId, int? resendToken) {
                    model.User user = Hive.box('myBox').get('user');
                    user.phoneNumber = countryCode + phoneController.text;
                    Hive.box('myBox').put('user', user);

                    Navigator.pushNamed(
                      context,
                      AppRouter.verificationRoute,
                      arguments: verificationId,
                    );
                  },
                ),
              );
        },
      ),
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
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                // label
                const Text(
                  'Phone number',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.lightGray,
                  ),
                ),
                // intl phone field
                IntlPhoneField(
                  controller: phoneController,
                  initialCountryCode: 'US',
                  onCountryChanged: (value) {
                    countryCode = '+${value.dialCode}';
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightBorderGray,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.lightBorderGray,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
