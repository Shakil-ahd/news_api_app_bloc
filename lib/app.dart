import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/bloc/news_event.dart';
import 'package:news_api_app_bloc/screens/newsScreen/categories/bloc/category_bloc.dart';
import 'package:news_api_app_bloc/screens/splashScreen/UI/splash_screen.dart';
import 'package:news_api_app_bloc/screens/splashScreen/bloc/splash_bloc.dart';
import 'bloc/news_bloc.dart';
import 'repository/news_repository.dart';

class MyApp extends StatelessWidget {
  final NewsRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NewsBloc(repository)..add(FetchNewsEvent()),
        ),
        BlocProvider(create: (_) => CategoryBloc()),
        BlocProvider(create: (_) => SplashBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),

        home: SplashScreen(),
      ),
    );
  }
}
