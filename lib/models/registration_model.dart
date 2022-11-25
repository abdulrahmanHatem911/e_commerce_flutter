import 'package:equatable/equatable.dart';

class RegistrationModel extends Equatable {
  String message;
  String email;
  String username;
  List<String> roles;
  String token;
  RegistrationModel({
    this.message = '',
    this.email = '',
    this.username = '',
    this.roles = const [],
    this.token = '',
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        message: json["message"],
        email: json["email"],
        username: json["username"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        token: json["token"],
      );

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "email": email,
      "username": username,
      "roles": List<dynamic>.from(roles.map((x) => x)),
      "token": token,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        message,
        email,
        username,
        roles,
        token,
      ];
}
