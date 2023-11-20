import 'dart:io';

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? bio;
  File? image;
  String? phoneNumber;
  String? updatedAt;
  String? createdAt;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.bio,
    this.image,
    this.phoneNumber,
    this.updatedAt,
    this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    bio = json['bio'];
    image = json['image'];
    phoneNumber = json['phoneNumber'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['bio'] = this.bio;
    data['image'] = this.image;
    data['phoneNumber'] = this.phoneNumber;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
