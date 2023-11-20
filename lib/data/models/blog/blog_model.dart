class UserModel {
  String? id;
  String? title;
  String? description;
  String? userId;
  String? image;
  String? category;
  String? updatedAt;
  String? createdAt;

  UserModel({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.image,
    this.category,
    this.updatedAt,
    this.createdAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    userId = json['userId'];
    image = json['image'];
    category = json['category'];
    updatedAt = json['updatedAt'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['category'] = this.category;
    data['updatedAt'] = this.updatedAt;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
