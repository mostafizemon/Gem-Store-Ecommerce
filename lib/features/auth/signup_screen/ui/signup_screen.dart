import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/features/auth/signup_screen/bloc/sign_up_bloc.dart';
import 'package:gem_store/features/auth/widgets/auth_header_widgets.dart';
import 'package:gem_store/features/auth/widgets/custom_snackbar.dart';
import 'package:gem_store/features/auth/widgets/login_signup_widget.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
                  AuthHeaderWidgets(header: "Create\nyour account"),
                  SizedBox(height: 32.h),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      prefixIcon: Icon(
                        Icons.person,
                        color: AppColors.greyColor,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
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
                  BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                      final isPasswordVisible = state is SignUpVisibilityState
                          ? state.isPasswordVisible
                          : false;
                      final isConfirmPasswordVisible =
                          state is SignUpVisibilityState
                          ? state.isConfirmPasswordVisible
                          : false;

                      return Column(
                        children: [
                          TextFormField(
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return "Password must be 6 characters or more";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(
                                Icons.password,
                                color: AppColors.greyColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  context.read<SignUpBloc>().add(
                                    TogglePasswordVisibily(),
                                  );
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          TextFormField(
                            controller: confirmPasswordController,
                            obscureText: !isConfirmPasswordVisible,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return "Password must be 6 characters or more";
                              }
                              if (passwordController.text != value) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              prefixIcon: Icon(
                                Icons.password,
                                color: AppColors.greyColor,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isConfirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  context.read<SignUpBloc>().add(
                                    ToggleConfirmPasswordVisibily(),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 32.h),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        showCustomSnackbar(
                          context,
                          "Success",
                          "Check you email to verify your account",
                        );
                        Get.offNamed(AppRoutes.loginScreen);
                      } else if (state is SignUpFailure) {
                        showCustomSnackbar(context, "Failed", state.error);
                      }
                    },
                    builder: (context, state) {
                      if (state is SignUpLoading) {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        );
                      }
                      return SizedBox(
                        width: double.infinity.w,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignUpBloc>().add(
                                SignupSubmitted(
                                  emailController.text.trim(),
                                  passwordController.text,
                                  nameController.text.trim(),
                                ),
                              );
                            }
                          },
                          child: Text("SIGN UP"),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  LoginSignupWidget(
                    text: "Already have account?",
                    button: "Log in",
                    onTap: () {
                      Get.offNamed(AppRoutes.loginScreen);
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
