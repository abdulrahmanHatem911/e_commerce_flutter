class AuthModel {
  AuthModel({
    required this.message,
    required this.isAuthenticated,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.username,
    required this.roles,
    required this.cartId,
    required this.favoriteId,
    required this.token,
    required this.expireOn,
    required this.refreshToken,
    required this.refreshTokenExpiration,
  });

  String message;
  bool isAuthenticated;
  String id;
  String firstName;
  String lastName;
  String email;
  String username;
  List<String> roles;
  int cartId;
  int favoriteId;
  String token;
  DateTime expireOn;
  String refreshToken;
  DateTime refreshTokenExpiration;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        message: json["message"],
        isAuthenticated: json["isAuthenticated"],
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        username: json["username"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        cartId: json["cartId"],
        favoriteId: json["favoriteId"],
        token: json["token"],
        expireOn: DateTime.parse(json["expireOn"]),
        refreshToken: json["refreshToken"],
        refreshTokenExpiration: DateTime.parse(json["refreshTokenExpiration"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "isAuthenticated": isAuthenticated,
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "username": username,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "cartId": cartId,
        "favoriteId": favoriteId,
        "token": token,
        "expireOn": expireOn.toIso8601String(),
        "refreshToken": refreshToken,
        "refreshTokenExpiration": refreshTokenExpiration.toIso8601String(),
      };
}
