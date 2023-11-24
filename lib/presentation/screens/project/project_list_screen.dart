import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_state.dart';
import 'package:assignment12_front_end/presentation/screens/project/create_edit_project_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/project_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectListScreen extends StatefulWidget {
  final String userId;
  const ProjectListScreen({
    super.key,
    required this.userId,
  });

  static const routeName = 'projects';

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  @override
  void initState() {
    BlocProvider.of<ProjectCubit>(context).fetchProjectByUserId(
      widget.userId,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProjectCubit, ProjectState>(
        builder: (context, state) {
          if (state is ProjectLoadingState && state.projects.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProjectErrorState && state.projects.isEmpty) {
            return Text(state.message);
          } else if (state is ProjectLoadedState && state.projects.isEmpty) {
            return const Center(
              child: Text('No Projects added!'),
            );
          }
          return ListView(
            children: [
              ProjectDisplayWidget(
                projects: state.projects,
                choice: true,
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CreateEditProjectScreen.routeName,
            arguments: ProjectPreferences(
              projectChoice: false,
              userId: widget.userId,
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
