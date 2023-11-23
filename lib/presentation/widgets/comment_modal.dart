import 'package:assignment12_front_end/core/ui.dart';
import 'package:assignment12_front_end/logic/cubits/comment_cubit/comment_state.dart';
import 'package:assignment12_front_end/presentation/widgets/primary_textfield.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assignment12_front_end/logic/cubits/comment_cubit/comment_cubit.dart';
import 'package:assignment12_front_end/data/models/comment/comment_model.dart';

class CommentModal extends StatefulWidget {
  final String blogId;

  const CommentModal({super.key, required this.blogId});

  @override
  State<CommentModal> createState() => _CommentModalState();
}

class _CommentModalState extends State<CommentModal> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<CommentCubit>(context).getCommentsForBlog(widget.blogId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: BlocBuilder<CommentCubit, CommentState>(
            builder: (context, state) {
              if (state is CommentLoadingState) {
                return const CircularProgressIndicator();
              } else if (state is CommentLoadedState) {
                return ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    CommentModel comment = state.comments[index];
                    return ListTile(
                      leading: ClipOval(
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width / 12,
                          height: MediaQuery.of(context).size.width / 12,
                          fit: BoxFit.cover,
                          imageUrl: '${comment.author?.image}',
                        ),
                      ),
                      title: Text(
                        '${comment.author?.fullName}',
                        style: TextStyles.body2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(comment.content!),
                    );
                  },
                );
              } else if (state is CommentErrorState) {
                return Text('Error: ${state.message}');
              } else {
                return Container();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  child: PrimaryTextField(
                labelText: 'Enter a Comment..',
                controller: _commentController,
              )),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  CommentModel newComment = CommentModel(
                    blog: widget.blogId,
                    content: _commentController.text,
                  );
                  BlocProvider.of<CommentCubit>(context).addComment(newComment);
                  _commentController.clear();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
