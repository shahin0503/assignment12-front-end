import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:assignment12_front_end/data/repositories/project_repository.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit() : super(ProjectInitialState());

  final ProjectRepository _projectRepository = ProjectRepository();

  void fetchProjectByUserId(String userId) async {
    emit(ProjectLoadingState(state.projects));

    try {
      List<ProjectModel> projects =
          await _projectRepository.fetchProjectByUser(userId);

      emit(ProjectLoadedState(projects));
    } catch (error) {
      emit(ProjectErrorState(state.projects, error.toString()));
    }
  }

  void addProject(ProjectModel newProject) async {
    emit(ProjectLoadingState(state.projects));
    try {
      await _projectRepository.addProject(newProject);
      fetchProjectByUserId(newProject.userId!);
    } catch (error) {
      emit(ProjectErrorState(state.projects, error.toString()));
    }
  }

  void updateProject(ProjectModel updatedProject, String projectId) async {
    emit(ProjectLoadingState(state.projects));

    try {
      await _projectRepository.updateProject(updatedProject, projectId);
      fetchProjectByUserId(updatedProject.userId!);
    } catch (error) {
      emit(ProjectErrorState(state.projects, error.toString()));
    }
  }

  void deleteProject(String projectId, String userId) async {
    emit(ProjectLoadingState(state.projects));

    try {
      await _projectRepository.deleteProject(projectId);
      fetchProjectByUserId(userId);
    } catch (error) {
      emit(ProjectErrorState(state.projects, error.toString()));
    }
  }
}
