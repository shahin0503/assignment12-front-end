import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:flutter/material.dart';
import 'package:assignment12_front_end/core/ui.dart';

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
                        Text(
                          'Description:',
                          style: TextStyles.body2.copyWith(
                            color: AppColors.accent,
                          ),
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
                        if (choice == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ],
                          ),
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
