import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:gem_store/app_constrains/app_routes.dart';
import 'package:gem_store/services/local_storage_service.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()){
    _startSplashTimer();
  }

  Future<void> _startSplashTimer() async{
    emit(SplashLoading());
    await Future.delayed(Duration(seconds: 3));
    final localStorage=LocalStorageService();
    final isLoggedIn=localStorage.isLoggedIn;
    emit(SplashLoaded());
    if (isLoggedIn) {
      Get.offNamed(AppRoutes.bottomNavScreen);
    } else {
      Get.offNamed(AppRoutes.welcomeScreen);
    }
  }
}
