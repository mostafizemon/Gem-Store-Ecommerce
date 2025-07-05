import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gem_store/services/local_storage_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfileData>(_onFetchProfileData);
    on<Logout>(_onLogout);
  }

  Future<void> _onFetchProfileData(
    FetchProfileData event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(const ProfileError('User not logged in.'));
        return;
      }

      final ordersSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userUid', isEqualTo: user.uid)
          .get();
      final totalOrders = ordersSnapshot.docs.length;

      emit(ProfileLoaded(
        fullName: user.displayName,
        email: user.email,
        totalOrders: totalOrders,
      ));
    } catch (e) {
      emit(ProfileError('Failed to fetch profile data: ${e.toString()}'));
    }
  }

  Future<void> _onLogout(
    Logout event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      await FirebaseAuth.instance.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      await LocalStorageService().init(); // Re-initialize LocalStorageService
      emit(ProfileLoggedOut());
    } catch (e) {
      emit(ProfileError('Failed to logout: ${e.toString()}'));
    }
  }
}
