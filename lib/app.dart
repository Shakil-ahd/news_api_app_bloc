import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/bloc/news_event.dart';
import 'package:news_api_app_bloc/categories/bloc/category_bloc.dart';
import 'screens/home_screen.dart';
import 'bloc/news_bloc.dart';
import 'repository/news_repository.dart';

void main() {
  final newsRepository = NewsRepository();
  runApp(MyApp(repository: newsRepository));
}

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
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen()),
    );
  }
}
