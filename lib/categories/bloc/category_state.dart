abstract class CategoryState {}

class CategoryInitial extends CategoryState {
  final String selectedCategory;
  CategoryInitial(this.selectedCategory);
}
