import 'package:assignment12_front_end/data/models/project/project_model.dart';

abstract class ProjectState {
  final List<ProjectModel> projects;
  ProjectState(this.projects);
}

class ProjectInitialState extends ProjectState {
  ProjectInitialState() : super([]);
}

class ProjectLoadingState extends ProjectState {
  ProjectLoadingState(super.projects);
}

class ProjectLoadedState extends ProjectState {
  ProjectLoadedState(super.projects);
}

class ProjectErrorState extends ProjectState {
  final String message;
  ProjectErrorState(
    super.projects,
    this.message,
  );
}
