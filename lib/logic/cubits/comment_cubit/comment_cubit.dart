import 'package:assignment12_front_end/data/models/comment/comment_model.dart';
import 'package:assignment12_front_end/data/repositories/comment_repository.dart';
import 'package:assignment12_front_end/logic/cubits/comment_cubit/comment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit() : super(CommentInitialState());

  final CommentRepository _commentRepository = CommentRepository();

  void getCommentsForBlog(String blogId) async {
    emit(CommentLoadingState(state.comments));

    try {
      List<CommentModel> comments =
          await _commentRepository.getCommentsForBlog(blogId);
      emit(CommentLoadedState(comments));
    } catch (error) {
      emit(CommentErrorState(state.comments, error.toString()));
    }
  }

  void addComment(CommentModel newComment) async {
    emit(CommentLoadingState(state.comments));

    try {
      await _commentRepository.addComment(newComment);

      getCommentsForBlog(newComment.blog!);
    } catch (error) {
      emit(CommentErrorState(state.comments, error.toString()));
    }
  }
}
