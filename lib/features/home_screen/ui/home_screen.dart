import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/common/widgets/appbar_widget.dart';
import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
import 'package:gem_store/features/home_screen/widgets/category_widget.dart';
import 'package:gem_store/features/home_screen/widgets/home_slider.dart';
import 'package:gem_store/features/home_screen/widgets/products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<HomeBloc>().add(LoadBannerEvent());
    context.read<HomeBloc>().add(const LoadProductsEvent(0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: "Gemstore", onNotificationTap: () {}),
      drawer: const Drawer(),
      body: ListView(
        children: [
          CategoryWidget(),
          HomeSlider(),
          SizedBox(height: 16.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ProductsWidget(),
          ),
        ],
      ),
    );
  }
}
