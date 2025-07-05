import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/features/cart_screen/bloc/cart_bloc.dart';
import 'package:gem_store/features/cart_screen/widgets/cart_item_widget.dart';
import 'package:gem_store/theme/app_colors.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc()..add(FetchCartItems()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Gemstore",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.sp,
              letterSpacing: 1.5,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartLoaded) {
              if (state.cartItems.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return ListView.builder(
                itemCount: state.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = state.cartItems[index];
                  return Dismissible(
                    key: Key(cartItem.cartDocId),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.w),
                      color: Colors.red,
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    onDismissed: (direction) {
                      context.read<CartBloc>().add(
                        RemoveCartItem(cartItem.cartDocId),
                      );
                    },
                    child: CartItemWidget(cartItem: cartItem),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        bottomNavigationBar: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoaded && state.cartItems.isNotEmpty) {
              return GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.confirmOrderScreen,
                  arguments: state.cartItems,
                ),
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
                      Icon(Icons.shopping_bag, color: AppColors.whiteColor),
                      SizedBox(width: 8.w),
                      Text(
                        "Check Out",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
