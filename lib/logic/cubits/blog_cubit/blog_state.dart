import 'package:assignment12_front_end/data/models/blog/blog_model.dart';

abstract class BlogState {
  final List<BlogModel> blogs;
  BlogState(this.blogs);
}

class BlogInitialState extends BlogState {
  BlogInitialState() : super([]);
}

class BlogLoadingState extends BlogState {
  BlogLoadingState(super.blogs);
}

class BlogLoadedState extends BlogState {
  BlogLoadedState(super.blogs);
}

class BlogErrorState extends BlogState {
  final String message;
  BlogErrorState(
    super.blogs,
    this.message,
  );
}
