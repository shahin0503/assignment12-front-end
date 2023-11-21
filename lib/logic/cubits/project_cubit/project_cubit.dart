import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/data/repositories/project_repository.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectCubit extends Cubit<ProjectState> {
  final UserModel user;
  ProjectCubit(this.user) : super(ProjectInitialState()) {
    _initialize();
  }

  final ProjectRepository _projectRepository = ProjectRepository();

  void _initialize() async {
    emit(ProjectLoadingState(state.projects));

    try {
      List<ProjectModel> projects = await _projectRepository.fetchProjectByUser(user.id!);

      emit(ProjectLoadedState(projects));
    } catch (error) {
      emit(ProjectErrorState(state.projects, error.toString()));
    }
  }
}
