import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  final int? success;
  final String? token;
  final User? user;

  LoginResponseModel({
    this.success,
    this.token,
    this.user,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    success: json["success"],
    token: json["token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  final dynamic name;
  final dynamic username;
  final String? userId;
  final String? email;
  final dynamic mobileNumber;
  final String? roleType;
  final String? roleId;
  final dynamic photo;
  final String? roleIdentity;

  User({
    this.name,
    this.username,
    this.userId,
    this.email,
    this.mobileNumber,
    this.roleType,
    this.roleId,
    this.photo,
    this.roleIdentity,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    username: json["username"],
    userId: json["userId"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    roleType: json["roleType"],
    roleId: json["roleId"],
    photo: json["photo"],
    roleIdentity: json["roleIdentity"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "userId": userId,
    "email": email,
    "mobileNumber": mobileNumber,
    "roleType": roleType,
    "roleId": roleId,
    "photo": photo,
    "roleIdentity": roleIdentity,
  };
}
