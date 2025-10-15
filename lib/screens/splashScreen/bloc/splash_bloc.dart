import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/screens/splashScreen/bloc/splash_event.dart';
import 'package:news_api_app_bloc/screens/splashScreen/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashEvent>((event, emit) async {
      emit(SplashFadeInState());
      await Future.delayed(const Duration(seconds: 3));
      emit(SplashCompletedState());
    });
  }
}
