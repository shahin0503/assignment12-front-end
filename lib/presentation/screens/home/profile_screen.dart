import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/data/models/user/user_model.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment12_front_end/presentation/screens/project/project_list_screen.dart';
import 'package:assignment12_front_end/presentation/screens/user/edit_profile_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserErrorState) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is UserLoggedInState) {
          return userProfile(state.userModel);
        }
        return const Center(
          child: Text('An error occured!!'),
        );
      },
    );
  }

  Widget userProfile(UserModel userModel) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.cover,
                imageUrl: '${userModel.image}',
              ),
            ),
            const GapWidget(),
            Text(
              '${userModel.fullName}',
              style: TextStyles.heading3,
            ),
            Text(
              '${userModel.email}',
              style: TextStyles.body2,
            ),
            Text(
              '${userModel.bio}',
              style: TextStyles.body2,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const GapWidget(),
          ],
        ),
        const Divider(),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, EditProfileScreen.routeName);
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            CupertinoIcons.person,
          ),
          title: Text(
            'Edit Profile',
            style: TextStyles.body1,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProjectListScreen.routeName,
              arguments: userModel.id
            );
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            CupertinoIcons.cube_box_fill,
          ),
          title: Text(
            'Edit Projects',
            style: TextStyles.body1,
          ),
        ),
        ListTile(
          onTap: () {
            BlocProvider.of<UserCubit>(context).signOut();
          },
          contentPadding: EdgeInsets.zero,
          leading: const Icon(
            Icons.exit_to_app,
            color: Colors.red,
          ),
          title: Text(
            'Sign Out',
            style: TextStyles.body1.copyWith(
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
