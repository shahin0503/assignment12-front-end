class BlogModel {
  String? id;
  String? title;
  String? description;
  String? userId;
  String? image;
  String? category;

  BlogModel({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.image,
    this.category,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['content'];
    userId = json['userId'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.description;
    data['userId'] = this.userId;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
