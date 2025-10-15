import 'package:news_api_app_bloc/Models/news_model.dart';

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<NewsArticle> articles;
  NewsLoadedState(this.articles);
}

class NewsErrorState extends NewsState {
  final String errorMsg;
  NewsErrorState(this.errorMsg);
}
