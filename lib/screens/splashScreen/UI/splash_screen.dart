import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/screens/home/UI/home_screen.dart';
import 'package:news_api_app_bloc/screens/splashScreen/bloc/splash_event.dart';
import 'package:news_api_app_bloc/screens/splashScreen/bloc/splash_state.dart';
import '../bloc/splash_bloc.dart';
import '../widgets/news_logo.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(StartSplashEvent()),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            double opacity = 0.0;
            if (state is SplashFadeInState || state is SplashCompletedState) {
              opacity = 1.0;
            }
            if (state is SplashCompletedState) {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              });
            }

            return Center(
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOut,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    NewsLogo(size: 150),
                    SizedBox(height: 20),
                    Text(
                      'WORLD NEWS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Bringing news to life, one story at a time.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
