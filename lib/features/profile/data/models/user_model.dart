import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.username,
    required super.fullName,
    required super.status,
    required super.email,
    required super.phone,
    required super.address,
    required super.salary,
    required super.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json["username"],
      fullName: json["full_name"],
      status: json["status"],
      email: json["email"],
      phone: json["phone"],
      address: json["address"],
      salary: json["salary"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "full_name": fullName,
      "status": status,
      "email": email,
      "phone": phone,
      "address": address,
      "salary": salary,
      "image": image,
    };
  }
}
