import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'intro_screen_state.dart';

class IntroScreenCubit extends Cubit<IntroScreenState> {
  IntroScreenCubit() : super(IntroScreenState(pageIndex: 0));

  void onPageChanged(int newIndex){
    emit(IntroScreenState(pageIndex: newIndex));
  }
}
