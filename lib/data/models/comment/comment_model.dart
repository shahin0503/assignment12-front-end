import 'package:assignment12_front_end/data/models/user/user_model.dart';

class CommentModel {
  String? id;
  String? content;
  UserModel? author;
  String? blog;

  CommentModel({
    this.id,
    this.content,
    this.author,
    this.blog,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    content = json['content'];
    author = UserModel.fromJson(json['author']);
    blog = json['blogId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      '_id': id,
      'content': content,
      'author': author?.toJson(),
      'blogId': blog,
    };
    return data;
  }
}
