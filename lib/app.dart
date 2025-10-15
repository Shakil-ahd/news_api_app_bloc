import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/bloc/news_event.dart';
import 'bloc/news_bloc.dart';
import 'repository/news_repository.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  final NewsRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => NewsBloc(repository)..add(FetchData()),
        child: const HomeScreen(),
      ),
    );
  }
}
