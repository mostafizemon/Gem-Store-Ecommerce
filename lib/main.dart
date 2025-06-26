import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gem_store/features/auth/login_screen/bloc/login_bloc.dart';
import 'package:gem_store/features/auth/signup_screen/bloc/sign_up_bloc.dart';
import 'package:gem_store/features/intro_screens/cubit/intro_screen_cubit.dart';
import 'package:gem_store/features/intro_screens/ui/welcome_screen.dart';
import 'package:gem_store/theme/app_theme.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Firebase.initializeApp();
    runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => IntroScreenCubit()),
        BlocProvider(create: (context) => SignUpBloc()),
        BlocProvider(create: (context)=>LoginBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Gem Store',
            theme: AppTheme.lightThemeData,
            home: WelcomeScreen(),
          );
        },
      ),
    );
  }
}
