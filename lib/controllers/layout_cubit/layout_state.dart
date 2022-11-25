part of 'layout_cubit.dart';

@immutable
abstract class LayoutState {}

class LayoutInitial extends LayoutState {}

class LayoutChangeBottomNavBarState extends LayoutState {}

class LayoutChangeFavoriteState extends LayoutState {}

//products
class LayoutGetProductLoadingState extends LayoutState {}

class LayoutGetProductSuccessState extends LayoutState {}

class LayoutGetProductErrorState extends LayoutState {
  final String error;
  LayoutGetProductErrorState(this.error);
}

//categories
class LayoutGetCategoryLoadingState extends LayoutState {}

class LayoutGetCategorySuccessState extends LayoutState {}

class LayoutGetCategoryErrorState extends LayoutState {
  final String error;
  LayoutGetCategoryErrorState(this.error);
}

//get product by category id
class LayoutGetProductByCategoryIdLoadingState extends LayoutState {}

class LayoutGetProductByCategoryIdSuccessState extends LayoutState {}

class LayoutGetProductByCategoryIdErrorState extends LayoutState {
  final String error;
  LayoutGetProductByCategoryIdErrorState(this.error);
}

//insert to database
class LayoutInsertToDatabaseState extends LayoutState {}

class LayoutGetFromDatabaseState extends LayoutState {}
