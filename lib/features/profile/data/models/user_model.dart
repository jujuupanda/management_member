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
    required super.activeWork,
    required super.division,
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
      activeWork: json["active_work"],
      division: json["division"],
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
      "active_work": activeWork,
      "division": division,
    };
  }

  UserModel copyWith(Map<String, dynamic> updates) {
    return UserModel(
      username: updates["username"] ?? username,
      fullName: updates["fullName"] ?? fullName,
      status: updates["status"] ?? status,
      email: updates["email"] ?? email,
      phone: updates["phone"] ?? phone,
      address: updates["address"] ?? address,
      salary: updates["salary"] ?? salary,
      image: updates["image"] ?? image,
      activeWork: updates["activeWork"] ?? activeWork,
      division: updates["division"] ?? division,
    );
  }
}
