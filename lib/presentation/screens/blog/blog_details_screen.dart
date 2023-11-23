import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment12_front_end/presentation/screens/blog/create_edit_blog_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/comment_modal.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:assignment12_front_end/presentation/widgets/generic_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDetailsScreen extends StatefulWidget {
  final BlogModel blogModel;

  const BlogDetailsScreen({
    super.key,
    required this.blogModel,
  });

  static const routeName = 'blog-details';

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        bool isCurrentUserAuthor = userState is UserLoggedInState &&
            userState.userModel.id == widget.blogModel.author?.id;

        return Scaffold(
          appBar: AppBar(
            actions: [
              if (isCurrentUserAuthor)
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.popAndPushNamed(
                          context,
                          CreateEditBlogScreen.routeName,
                          arguments: BlogPreferences(
                            blogChoice: true,
                            blogModel: widget.blogModel,
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
                              content: 'Are you sure you want to delete?',
                              onConfirm: () {
                                BlocProvider.of<BlogCubit>(context)
                                    .deleteBlog(widget.blogModel.id!);
                                Navigator.of(context).pop();
                              },
                              confirmButtonText: 'Delete',
                              cancelButtonText: 'Cancel',
                            );
                          },
                        );
                      },
                    ),
                  ],
                )
            ],
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.blogModel.title}',
                      style: TextStyles.heading3.copyWith(
                        color: AppColors.accent,
                      ),
                    ),
                    Text(
                      '${widget.blogModel.category}',
                      style: TextStyles.body1.copyWith(
                        color: AppColors.textLight,
                      ),
                    ),
                    const GapWidget(
                      size: -10,
                    ),
                    Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            width: MediaQuery.of(context).size.width / 12,
                            height: MediaQuery.of(context).size.width / 12,
                            fit: BoxFit.cover,
                            imageUrl: '${widget.blogModel.author?.image}',
                          ),
                        ),
                        const GapWidget(),
                        Text(
                          '${widget.blogModel.author?.fullName}',
                          style: TextStyles.body1,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 2,
                        fit: BoxFit.cover,
                        imageUrl: '${widget.blogModel.image}',
                      ),
                    ),
                    const GapWidget(),
                    Text(
                      '${widget.blogModel.description}',
                      style: TextStyles.body2,
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return CommentModal(blogId: widget.blogModel.id!);
                  });
            },
            child: const Icon(
              Icons.comment,
            ),
          ),
        );
      },
    );
  }
}
