import 'package:assignment12_front_end/data/models/user/user_model.dart';

class BlogModel {
  String? id;
  String? title;
  String? description;
  UserModel? author;
  String? image;
  String? category;

  BlogModel({
    this.id,
    this.title,
    this.description,
    this.author,
    this.image,
    this.category,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['content'];
    author = UserModel.fromJson(json['author']);
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'title': title,
      'content': description,
      'author': author?.toJson(),
      if (image != null) 'image': image,
      'category': category,
    };
    return data;
  }
}

class BlogPreferences {
  final bool blogChoice;
  final BlogModel? blogModel;

  BlogPreferences({
    required this.blogChoice,
    this.blogModel,
  });
}
