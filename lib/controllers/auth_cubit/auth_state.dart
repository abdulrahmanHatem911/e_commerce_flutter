abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthRegistrationLoadingState extends AuthState {}

class AuthRegistrationSuccessState extends AuthState {
  final String? user;
  AuthRegistrationSuccessState({this.user});
}

class AuthRegistrationErrorState extends AuthState {
  final String error;
  AuthRegistrationErrorState(this.error);
}

class AuthLoginLoadingState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  final String user;
  AuthLoginSuccessState({required this.user});
}

class AuthLoginErrorState extends AuthState {
  final String error;
  AuthLoginErrorState(this.error);
}

class AuthSignOutSuccessState extends AuthState {}

class AuthAssignRoleLoadingState extends AuthState {}

class AuthAssignRoleSuccessState extends AuthState {}

class AuthAssignRoleErrorState extends AuthState {
  final String error;
  AuthAssignRoleErrorState(this.error);
}
