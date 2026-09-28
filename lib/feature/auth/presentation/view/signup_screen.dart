import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/app_constants/app_colors.dart';
import 'package:to_do_app/core/app_constants/app_fonts.dart';
import 'package:to_do_app/core/app_constants/app_imgs.dart';
import 'package:to_do_app/feature/auth/data/model/user_model.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_cubit.dart';
import 'package:to_do_app/feature/auth/presentation/view_model/auth_state.dart';
import 'package:to_do_app/feature/auth/presentation/widgets/auth_text_fields.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignupFailState) {
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
        if (state is AuthSignupSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Your account has been created successfully , please verify your account",
                style: AppFonts.blue12Bold.copyWith(color: Colors.white),
              ),
              backgroundColor: Color(0xff000000).withAlpha(150),
              margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      child: Scaffold(
        
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 32.0),
                        child: Image.asset("${AppImgs.path}Logo.png"),
                      ),
                      Text("Create Your Account", style: AppFonts.black24Bold),
                      Text(
                        "Get started and stay organized with To Do.",
                        style: AppFonts.secondryTextColor18Bold.copyWith(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: AuthTextFields(
                                  controller: nameController,
                                  type: AuthTextFieldTypes.name,
                                  hintText: "Enter your full name",
                                ),
                              ),
                              AuthTextFields(
                                controller: emailController,
                                type: AuthTextFieldTypes.email,
                                hintText: "you@example.com",
                              ),
                              AuthTextFields(
                                controller: passwordController,
                                type: AuthTextFieldTypes.password,
                                hintText: "Enter your password",
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      UserModel user = UserModel(
                                        email: emailController.text,
                                        name: nameController.text,
                                      );
                                      context.read<AuthCubit>().signUp(
                                        user,
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
                                      return Text("Sign Up");
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
                          text: "Already have an account? ",
                          style: AppFonts.gray12Bold.copyWith(fontSize: 16),
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/login',
                                  );
                                },
                              text: "Log in",
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
        ),
      ),
    );
  }
}
