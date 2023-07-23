import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/widgets/buttons/default_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                PngAssets.mask,
                fit: BoxFit.cover,
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
                  Center(
                    child: SvgPicture.asset(SvgAssets.carrot),
                  ),
                  const SizedBox(height: 100),
                  const Text(
                    'Sign up', // Change the title to "Sign up"
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Create an account to get started', // Update the description
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Sign up", // Change the button text to "Sign up"
                    onTap: () {}, // Implement sign-up logic here
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Continue with Google", // Change button text
                    onTap: () {}, // Implement sign-up with Google logic here
                    backgroundColor: AppColors.googleBlue,
                    leading: SvgPicture.asset(SvgAssets.google),
                  ),
                  const SizedBox(height: 20),
                  DefaultButton(
                    text: "Continue with Facebook", // Change button text
                    onTap: () {}, // Implement sign-up with Facebook logic here
                    backgroundColor: AppColors.facebookBlue,
                    leading: SvgPicture.asset(SvgAssets.facebook),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }
}
