abstract class CategoryEvent {}

class SelectCategoryEvent extends CategoryEvent {
  final String category;
  SelectCategoryEvent(this.category);
}
