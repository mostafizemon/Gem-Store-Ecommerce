import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/features/cart_screen/bloc/cart_bloc.dart';
import 'package:gem_store/features/confirm_order_screen/bloc/confirm_order_bloc.dart';
import 'package:gem_store/features/bottom_nav_screen/cubit/bottom_nav_cubit.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({super.key});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = Get.arguments as List<CartItem>;
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmOrderBloc(),
      child: BlocListener<ConfirmOrderBloc, ConfirmOrderState>(
        listener: (context, state) {
          if (state is ConfirmOrderLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Processing Order...')),
            );
          } else if (state is ConfirmOrderSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            // Reset BottomNavCubit to home screen (index 0)
            context.read<BottomNavCubit>().changeTab(0);
            Get.offAllNamed(AppRoutes.bottomNavScreen);
          } else if (state is ConfirmOrderFailure) {
            Get.snackbar(
              "Error",
              state.error,
              backgroundColor: Colors.red.shade100,
              colorText: Colors.black,
            );
          }
        },
        child: Builder(
          builder: (context) {
            // New Builder to provide a new context
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "Confirm Order",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                    letterSpacing: 1.5,
                  ),
                ),
                centerTitle: true,
              ),
              body: Padding(
                padding: EdgeInsets.all(16.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Delivery Information",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          prefixIcon: const Icon(Icons.location_on),
                        ),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          prefixIcon: const Icon(Icons.phone),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          if (value.length < 10) {
                            return 'Phone number must be at least 10 digits';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<ConfirmOrderBloc>().add(
                      ConfirmOrder(
                        address: _addressController.text,
                        phoneNumber: _phoneController.text,
                        cartItems: cartItems,
                      ),
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 72.h,
                  decoration: BoxDecoration(
                    color: AppColors.introScreenBgColor,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle, color: AppColors.whiteColor),
                      SizedBox(width: 8.w),
                      Text(
                        "Confirm Order",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
