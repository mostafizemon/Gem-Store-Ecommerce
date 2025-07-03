import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/features/auth/login_screen/bloc/login_bloc.dart';
import 'package:gem_store/features/auth/login_screen/ui/login_screen.dart';
import 'package:gem_store/features/auth/signup_screen/bloc/sign_up_bloc.dart';
import 'package:gem_store/features/auth/signup_screen/ui/signup_screen.dart';
import 'package:gem_store/features/bottom_nav_screen/cubit/bottom_nav_cubit.dart';
import 'package:gem_store/features/bottom_nav_screen/ui/bottom_nav_screen.dart';
import 'package:gem_store/features/cart_screen/ui/cart_screen.dart';
import 'package:gem_store/features/home_screen/bloc/home_bloc.dart';
import 'package:gem_store/features/home_screen/ui/home_screen.dart';
import 'package:gem_store/features/intro_screens/cubit/intro_screen_cubit.dart';
import 'package:gem_store/features/intro_screens/ui/intro_screen.dart';
import 'package:gem_store/features/intro_screens/ui/welcome_screen.dart';
import 'package:gem_store/features/profile_screen/ui/profile_screen.dart';
import 'package:gem_store/features/search_screen/ui/search_screen.dart';
import 'package:gem_store/features/splash_screen/cubit/splash_cubit.dart';
import 'package:gem_store/features/splash_screen/ui/splash_screen.dart';
import 'package:gem_store/services/local_storage_service.dart';
import 'package:gem_store/theme/app_theme.dart';
import 'package:get/get.dart';

import 'features/product_details_screen/ui/product_details_screen.dart';
import 'features/search_screen/bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService().init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IntroScreenCubit()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => SplashCubit()),
        BlocProvider(create: (context) => BottomNavCubit()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => SearchBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            initialRoute: AppRoutes.welcomeScreen,
            getPages: [
              GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
              GetPage(
                name: AppRoutes.splashScreen,
                page: () => WelcomeScreen(),
              ),
              GetPage(name: AppRoutes.introScreen, page: () => IntroScreen()),
              GetPage(name: AppRoutes.loginScreen, page: () => LoginScreen()),
              GetPage(name: AppRoutes.signupScreen, page: () => SignupScreen()),
              GetPage(name: AppRoutes.homeScreen, page: () => HomeScreen()),
              GetPage(
                name: AppRoutes.bottomNavScreen,
                page: () => BottomNavScreen(),
              ),
              GetPage(name: AppRoutes.cartScreen, page: () => CartScreen()),
              GetPage(
                name: AppRoutes.profileScreen,
                page: () => ProfileScreen(),
              ),
              GetPage(name: AppRoutes.searchScreen, page: () => SearchScreen()),
              GetPage(
                name: AppRoutes.productDetailsScreen,
                page: () => ProductDetailsScreen(),
              ),
            ],
            debugShowCheckedModeBanner: false,
            title: 'Gem Store',
            theme: AppTheme.lightThemeData,
          );
        },
      ),
    );
  }
}
