import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_cubit.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_state.dart';
import 'package:assignment12_front_end/presentation/screens/blog/blog_details_screen.dart';
import 'package:assignment12_front_end/presentation/screens/blog/create_edit_blog_screen.dart';
import 'package:assignment12_front_end/presentation/widgets/gap_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({super.key});

  @override
  State<BlogsScreen> createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          if (state is BlogLoadingState && state.blogs.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is BlogErrorState && state.blogs.isEmpty) {
            return Center(
              child: Text(state.message),
            );
          }
          return ListView.builder(
            itemCount: state.blogs.length,
            itemBuilder: (context, index) {
              final blog = state.blogs[index];
              return Card(
                elevation: 4,
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      BlogDetailsScreen.routeName,
                      arguments: blog,
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.width / 4,
                          fit: BoxFit.cover,
                          imageUrl: '${blog.image}',
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${blog.title}',
                              style: TextStyles.body1.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${blog.category}',
                              style: TextStyles.body2.copyWith(
                                color: AppColors.textLight,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const GapWidget(
                              size: -10,
                            ),
                            Text(
                              '${blog.description}',
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            CreateEditBlogScreen.routeName,
            arguments: BlogPreferences(
              blogChoice: false,
            ),
          );
        },
        child: const Icon(
          Icons.add_task,
        ),
      ),
    );
  }
}
