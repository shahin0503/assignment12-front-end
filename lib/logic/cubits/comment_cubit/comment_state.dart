import 'package:assignment12_front_end/data/models/comment/comment_model.dart';

abstract class CommentState {
  final List<CommentModel> comments;
  CommentState(this.comments);
}

class CommentInitialState extends CommentState {
  CommentInitialState() : super([]);
}

class CommentLoadingState extends CommentState {
  CommentLoadingState(super.comments);
}

class CommentLoadedState extends CommentState {
  CommentLoadedState(super.comments);
}

class CommentErrorState extends CommentState {
  final String message;
  CommentErrorState(
    super.comments,
    this.message,
  );
}
