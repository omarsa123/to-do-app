import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_constants/app_colors.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/app_constants/app_imgs.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_state.dart';
import 'package:to_do_app/feature/auth/presentation/widgets/auth_text_fields.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoginSuccessState) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: state.user,
          );
        }
        if (state is AuthLoginFailState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msg),
              backgroundColor: Color(0xff000000).withAlpha(150),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Image.asset("${AppImgs.path}Logo.png"),
                  ),
                  Text("Welcome Back ", style: AppFonts.black24Bold),
                  Text(
                    "Log in ti continue to your tasks",
                    style: AppFonts.secondryTextColor18Bold,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: AuthTextFields(
                              controller: emailController,
                              type: AuthTextFieldTypes.email,
                              hintText: "you@example.com",
                            ),
                          ),
                          AuthTextFields(
                            controller: passwordController,
                            type: AuthTextFieldTypes.password,
                            hintText: "Enter your password",
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: context.read<AuthCubit>().isRememberMe,
                                onChanged: ((value) => context
                                    .read<AuthCubit>()
                                    .toggleRememberMe(value!)),
                              ),
                              Text(
                                "Remeber Me",
                                style: AppFonts.gray12Bold.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  context.read<AuthCubit>().login(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                foregroundColor: Colors.white,
                                minimumSize: Size(350, 50),
                              ),
                              child: BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoadingState) {
                                    return CircularProgressIndicator();
                                  }
                                  return Text("Log in");
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  RichText(
                    text: TextSpan(
                      text: "Don't have an account? ",
                      style: AppFonts.gray12Bold.copyWith(fontSize: 16),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/signup',
                              );
                            },
                          text: "Sing Up",
                          style: AppFonts.blue12Bold.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
