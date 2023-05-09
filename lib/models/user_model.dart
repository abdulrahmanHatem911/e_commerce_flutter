class UserModel {
  final String firstName;
  final String lastName;
  final String address;
  final String phone;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'],
      lastName: json['lastName'],
      address: json['address'],
      phone: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
      'phoneNumber': phone,
    };
  }
}
