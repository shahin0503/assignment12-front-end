class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? bio;
  String? image;
  String? phoneNumber;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.bio,
    this.image,
    this.phoneNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    bio = json['bio'];
    image = json['image'];
    phoneNumber = json['phoneNumber'];
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

    return data;
  }
}
