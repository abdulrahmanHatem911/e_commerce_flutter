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

//search
class LayoutSearchLoadingState extends LayoutState {}

class LayoutSearchSuccessState extends LayoutState {}

class LayoutSearchErrorState extends LayoutState {
  final String error;
  LayoutSearchErrorState(this.error);
}

//get cart items
class LayoutGetCartItemsLoadingState extends LayoutState {}

class LayoutGetCartItemsSuccessState extends LayoutState {}

class LayoutGetCartItemsErrorState extends LayoutState {
  final String error;
  LayoutGetCartItemsErrorState(this.error);
}

class PaymentAuthLoadingStates extends LayoutState {}

class PaymentAuthSuccessStates extends LayoutState {}

class PaymentAuthErrorStates extends LayoutState {
  final String error;
  PaymentAuthErrorStates(this.error);
}

// for order id
class PaymentOrderIdLoadingStates extends LayoutState {}

class PaymentOrderIdSuccessStates extends LayoutState {}

class PaymentOrderIdErrorStates extends LayoutState {
  final String error;
  PaymentOrderIdErrorStates(this.error);
}

// for request token
class PaymentRequestTokenLoadingStates extends LayoutState {}

class PaymentRequestTokenSuccessStates extends LayoutState {}

class PaymentRequestTokenErrorStates extends LayoutState {
  final String error;
  PaymentRequestTokenErrorStates(this.error);
}

// for ref code
class PaymentRefCodeLoadingStates extends LayoutState {}

class PaymentRefCodeSuccessStates extends LayoutState {}

class PaymentRefCodeErrorStates extends LayoutState {
  final String error;
  PaymentRefCodeErrorStates(this.error);
}

class PaymentVisaUrlSuccessStates extends LayoutState {}

class PaymentVisaUrlErrorStates extends LayoutState {
  PaymentVisaUrlErrorStates();
}

class UserSignOutLoadingState extends LayoutState {}

class UserSignOutSuccessState extends LayoutState {}

class LayoutAddProductSuccessState extends LayoutState {}

class LayoutAddProductLoadingState extends LayoutState {}

class LayoutAddProductErrorState extends LayoutState {
  final String error;
  LayoutAddProductErrorState(this.error);
}

class LayoutAddCategoryLoadingState extends LayoutState {}

class LayoutAddCategorySuccessState extends LayoutState {}

class LayoutAddCategoryErrorState extends LayoutState {
  final String error;
  LayoutAddCategoryErrorState(this.error);
}

class LayoutUpdateCategoryLoadingState extends LayoutState {}

class LayoutUpdateCategorySuccessState extends LayoutState {}

class LayoutUpdateCategoryErrorState extends LayoutState {
  final String error;
  LayoutUpdateCategoryErrorState(this.error);
}

class LayoutDeleteCategoryLoadingState extends LayoutState {}

class LayoutDeleteCategorySuccessState extends LayoutState {}

class LayoutDeleteCategoryErrorState extends LayoutState {
  final String error;
  LayoutDeleteCategoryErrorState(this.error);
}

class LayoutUpdateProductLoadingState extends LayoutState {}

class LayoutUpdateProductSuccessState extends LayoutState {}

class LayoutUpdateProductErrorState extends LayoutState {
  final String error;
  LayoutUpdateProductErrorState(this.error);
}

class LayoutDeleteProductErrorState extends LayoutState {
  final String error;
  LayoutDeleteProductErrorState(this.error);
}

class GetCurrentUserLoadingState extends LayoutState {}

class GetCurrentUserSuccessState extends LayoutState {}

class GetCurrentUserErrorState extends LayoutState {
  final String error;
  GetCurrentUserErrorState(this.error);
}

class UpdateUserProfileLoadingState extends LayoutState {}

class UpdateUserProfileSuccessState extends LayoutState {}

class UpdateUserProfileErrorState extends LayoutState {
  final String error;
  UpdateUserProfileErrorState(this.error);
}
