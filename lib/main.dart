import 'package:flutter/material.dart';
import 'app.dart';
import 'repository/news_repository.dart';

void main() {
  final newsRepository = NewsRepository();
  runApp(MyApp(repository: newsRepository));
}
