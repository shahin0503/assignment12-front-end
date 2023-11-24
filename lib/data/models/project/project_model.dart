class ProjectModel {
  String? id;
  String? title;
  String? description;
  List<String>? technologiesUsed;
  String? userId;
  String? demoUrl;
  String? gitUrl;

  ProjectModel({
    this.id,
    this.title,
    this.description,
    this.technologiesUsed,
    this.userId,
    this.demoUrl,
    this.gitUrl,
  });

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    technologiesUsed = List<String>.from(json['technologies']);
    userId = json['owner'];
    demoUrl = json['demoLink'];
    gitUrl = json['githubLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['technologies'] = this.technologiesUsed;
    data['owner'] = this.userId;
    data['demoLink'] = this.demoUrl;
    data['githubLink'] = this.gitUrl;

    return data;
  }
}

class ProjectPreferences {
  final bool projectChoice;
  final ProjectModel? projectModel;
  final String userId;

  ProjectPreferences({
    required this.projectChoice,
    this.projectModel,
    required this.userId,
  });
}
