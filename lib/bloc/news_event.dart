abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {}

class FetchNewsByCategoryEvent extends NewsEvent {
  final String category;
  FetchNewsByCategoryEvent(this.category);
}
