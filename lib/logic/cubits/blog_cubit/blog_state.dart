import 'package:assignment12_front_end/data/models/blog/blog_model.dart';

abstract class BlogState {
  final List<BlogModel> blogs;
  final BlogModel? singleBlog;

  BlogState(this.blogs, {this.singleBlog});
}

class BlogInitialState extends BlogState {
  BlogInitialState() : super([]);
}

class BlogLoadingState extends BlogState {
  BlogLoadingState({List<BlogModel> blogs = const [], BlogModel? singleBlog})
      : super(blogs);
}

class BlogLoadedState extends BlogState {
  final List<BlogModel> loadedBlogs;
  final BlogModel? loadedSingleBlog;
  BlogLoadedState({
    required this.loadedBlogs,
    this.loadedSingleBlog,
  }) : super(
          loadedBlogs,
          singleBlog: loadedSingleBlog,
        );
}

class BlogErrorState extends BlogState {
  final String message;
  BlogErrorState(super.blogs, this.message);
}
