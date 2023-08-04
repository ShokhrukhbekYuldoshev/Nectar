import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:nectar/bloc/login/login_bloc.dart';
import 'package:nectar/presentation/utils/app_colors.dart';
import 'package:nectar/presentation/utils/app_router.dart';
import 'package:nectar/presentation/utils/assets.dart';
import 'package:nectar/presentation/utils/helpers.dart';
import 'package:nectar/presentation/widgets/buttons/default_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool ignoring = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          ignoring = true;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is LoginSuccess) {
          ignoring = false;
          Navigator.pop(context);

          if (isUserRegistered()) {
            Navigator.pushReplacementNamed(context, AppRouter.homeRoute);
          } else {
            Navigator.pushNamed(
              context,
              AppRouter.registerPhoneRoute,
            );
          }
        }
        if (state is LoginFailure) {
          ignoring = false;
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: IgnorePointer(
        ignoring: ignoring,
        child: Scaffold(
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SvgPicture.asset(SvgAssets.carrot),
                        ),
                        const SizedBox(height: 100),
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Enter your email and password to access',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            } else if (!isValidEmail(value.trim())) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isObscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(
                              fontSize: 16,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.forgotPasswordRoute,
                                );
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        DefaultButton(
                          text: "Log in",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                    LoginWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                          text: "Continue with Google",
                          onTap: () {
                            context.read<LoginBloc>().add(
                                  LoginWithGoogle(),
                                );
                          },
                          backgroundColor: AppColors.googleBlue,
                          leading: SvgPicture.asset(SvgAssets.google),
                        ),
                        const SizedBox(height: 20),
                        DefaultButton(
                          text: "Continue with Facebook",
                          onTap: () {
                            context.read<LoginBloc>().add(
                                  LoginWithFacebook(),
                                );
                          },
                          backgroundColor: AppColors.facebookBlue,
                          leading: SvgPicture.asset(SvgAssets.facebook),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, AppRouter.registerRoute);
                              },
                              child: const Text(
                                'Sign up',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
