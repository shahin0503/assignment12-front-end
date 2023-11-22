import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/logic/cubits/users_cubit/users_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/users_cubit/users_state.dart';
import 'package:assignment12_front_end/presentation/screens/user/user_details_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersCubit, UsersState>(
      builder: (context, state) {
        if (state is UsersLoadingState && state.users.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UsersErrorState && state.users.isEmpty) {
          return Center(
            child: Text(state.message.toString()),
          );
        }

        return ListView.builder(
          itemCount: state.users.length,
          itemBuilder: (context, index) {
            final user = state.users[index];
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: CupertinoButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    UserDetailsScreen.routeName,
                    arguments: user,
                  );
                },
                padding: EdgeInsets.zero,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                          fit: BoxFit.cover,
                          imageUrl: '${user.image}',
                        ),
                      ),
                    ),
                    const GapWidget(
                      size: -10,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.fullName}',
                            style: TextStyles.body1.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '${user.email}',
                            style: TextStyles.body2.copyWith(
                              color: AppColors.textLight,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const GapWidget(
                            size: -10,
                          ),
                          Text(
                            '${user.bio}',
                            style: TextStyles.body2.copyWith(
                              color: AppColors.textLight,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
