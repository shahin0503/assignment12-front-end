import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/project_cubit/project_state.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:assignment12_front_end/presentation/widgets/project_display.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDetailsScreen extends StatefulWidget {
  final UserModel userModel;

  const UserDetailsScreen({
    super.key,
    required this.userModel,
  });

  static const routeName = 'user-details';

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final userId = widget.userModel.id as String;

    context.read<ProjectCubit>().fetchProjectByUserId(userId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
      ),
      body: SafeArea(
        child: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            if (state is ProjectLoadingState && state.projects.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProjectErrorState && state.projects.isEmpty) {
              return Text(state.message);
            }
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipOval(
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            fit: BoxFit.cover,
                            imageUrl: '${widget.userModel.image}',
                          ),
                        ),
                      ),
                      const GapWidget(
                        size: -10,
                      ),
                      Center(
                        child: Text(
                          '${widget.userModel.fullName}',
                          style: TextStyles.body1.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.accent),
                        ),
                      ),
                      const GapWidget(
                        size: -15,
                      ),
                      Center(
                        child: Text(
                          '${widget.userModel.email}',
                          style: TextStyles.body1.copyWith(
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const GapWidget(),
                      Text(
                        'Bio',
                        style: TextStyles.body1.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.accent),
                      ),
                      Text(
                        '${widget.userModel.bio}',
                        style: TextStyles.body2,
                      ),
                      const GapWidget(
                        size: -5,
                      ),
                      Text(
                        'Projects',
                        style: TextStyles.body1.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.accent,
                        ),
                      ),
                      ProjectDisplayWidget(
                        projects: state.projects,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
