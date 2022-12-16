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
