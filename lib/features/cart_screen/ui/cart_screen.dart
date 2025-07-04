import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/features/cart_screen/bloc/cart_bloc.dart';

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
              if (state.products.isEmpty) {
                return const Center(child: Text('Your cart is empty'));
              }
              return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ListTile(
                    leading: Image.network(product.images![0]),
                    title: Text(product.name!),
                    subtitle: Text('\$${product.price!.toStringAsFixed(2)}'),
                  );
                },
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
