
import 'package:flutter/material.dart';
import 'package:gem_store/common/widgets/appbar_widget.dart';
import 'package:gem_store/features/home_screen/widgets/category_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: "Gemstore", onNotificationTap: () {}),
      drawer: const Drawer(),
      body: ListView(
        children: [
          CategoryWidget(),

        ],
      ),

    );
  }

}