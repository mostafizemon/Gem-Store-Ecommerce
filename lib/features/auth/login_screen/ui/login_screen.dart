import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/features/auth/login_screen/bloc/login_bloc.dart';
import 'package:gem_store/features/auth/signup_screen/ui/signup_screen.dart';
import 'package:gem_store/features/auth/widgets/auth_header_widgets.dart';
import 'package:gem_store/features/auth/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

import '../../../../theme/app_colors.dart';
import '../../widgets/login_signup_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  AuthHeaderWidgets(header: "Log into\nyour account"),
                  SizedBox(height: 32.h),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      prefixIcon: Icon(Icons.email, color: AppColors.greyColor),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is Required";
                      }
                      if (!value.isEmail) {
                        return "Your email is Inavalid";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 16.h),

                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (context, state) {
                      final isPasswordVisible =
                          state is PasswordToggleButtonState
                          ? state.isVisible
                          : false;
                      return TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 6) {
                            return "Password Must be 6 character or higher";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(
                            Icons.password,
                            color: AppColors.greyColor,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              context.read<LoginBloc>().add(
                                PasswordToggleButtonEvent(),
                              );
                            },
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () {},
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),
                  BlocConsumer<LoginBloc, LoginState>(
                    listener: (context, state) {
                      if (state is LoginFailed) {
                        showCustomSnackbar(
                          context,
                          "Login Failed",
                          state.error,
                        );
                      } else if (state is LoginSuccess) {
                        showCustomSnackbar(context, "Success", "Login Success");
                        Get.offNamed(AppRoutes.homeScreen);
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return SizedBox(
                        width: double.infinity.w,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginBloc>().add(
                                SubmitLoginButtonEvent(
                                  emailController.text.trim(),
                                  passwordController.text,
                                ),
                              );
                            }
                          },
                          child: Text("LOG IN"),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  LoginSignupWidget(
                    text: "Don't have an account?",
                    button: "Sign Up",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupScreen()),
                      );
                    },
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
