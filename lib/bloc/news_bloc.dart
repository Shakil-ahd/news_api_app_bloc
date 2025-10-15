import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  NewsBloc(this.repository) : super(NewsInitial()) {
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final news = await repository.fetchNews();
        emit(NewsLoadedState(news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });

    on<FetchNewsByCategoryEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final news = await repository.fetchNews(category: event.category);
        emit(NewsLoadedState(news));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
