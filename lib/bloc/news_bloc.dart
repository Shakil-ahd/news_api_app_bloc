import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_api_app_bloc/bloc/news_event.dart';
import 'package:news_api_app_bloc/bloc/news_state.dart';
import 'package:news_api_app_bloc/repository/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitialState()) {
    on<FetchData>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final news = await repository.FetchData();
        emit(NewsLoadedState(news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
