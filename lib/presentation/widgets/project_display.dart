import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_cubit.dart';
import 'package:assignment12_front_end/presentation/screens/project/create_edit_project_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/generic_dialog.dart';
import 'package:flutter/material.dart';
import 'package:assignment12_front_end/core/ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProjectDisplayWidget extends StatelessWidget {
  final List<ProjectModel> projects;
  final bool? choice;

  const ProjectDisplayWidget({
    super.key,
    required this.projects,
    this.choice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var project in projects)
          Card(
            elevation: 2,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                title: Text(
                  project.title!,
                  style: TextStyles.body1.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.accent,
                  ),
                ),
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16.0),
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Description:',
                              style: TextStyles.body2.copyWith(
                                color: AppColors.accent,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (choice == true)
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        CreateEditProjectScreen.routeName,
                                        arguments: ProjectPreferences(
                                          projectChoice: true,
                                          projectModel: project,
                                          userId: project.userId!,
                                        ),
                                      );
                                    },
                                  ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return GenericDialog(
                                          title: 'Delete Confirmation',
                                          content:
                                              'Are you sure you want to delete?',
                                          onConfirm: () {
                                            BlocProvider.of<ProjectCubit>(
                                                    context)
                                                .deleteProject(
                                              project.id!,
                                              project.userId!,
                                            );
                                          },
                                          confirmButtonText: 'Delete',
                                          cancelButtonText: 'Cancel',
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(project.description!),
                        Text(
                          'Technologies used:',
                          style: TextStyles.body2.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                        Text(project.technologiesUsed!.join(',')),
                        Text(
                          'GitUrl:',
                          style: TextStyles.body2.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                        Text(project.gitUrl!),
                        Text(
                          'DemoUrl:',
                          style: TextStyles.body2.copyWith(
                            color: AppColors.accent,
                          ),
                        ),
                        Text(project.demoUrl!),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
