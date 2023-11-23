import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/user_cubit/user_state.dart';
import 'package:assignment12_front_end/presentation/screens/blog/create_edit_blog_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
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
                          arguments: widget.blogModel,
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        
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
        );
      },
    );
  }
}
