import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/data/repositories/blog_repository.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogCubit extends Cubit<BlogState> {
  final BlogRepository _blogRepository = BlogRepository();

  BlogCubit() : super(BlogInitialState()) {
    getAllBlogs();
  }

  // Fetch all blogs
  void getAllBlogs() async {
    emit(BlogLoadingState(blogs: state.blogs));

    try {
      List<BlogModel> blogs = await _blogRepository.fetchAllBlogs();
      emit(BlogLoadedState(loadedBlogs: blogs));
    } catch (error) {
      emit(BlogErrorState(state.blogs, error.toString()));
    }
  }


  // Update a blog
  void updateBlog(BlogModel updatedBlog, String blogId) async {
    emit(BlogLoadingState(blogs: state.blogs));

    try {
      await _blogRepository.updateBlog(updatedBlog, blogId);
      // Fetch all blogs again after updating
      getAllBlogs();
    } catch (error) {
      emit(BlogErrorState(state.blogs, error.toString()));
    }
  }

  // Add a new blog
  void addBlog(BlogModel newBlog) async {
    emit(BlogLoadingState(blogs: state.blogs));

    try {
      await _blogRepository.addBlog(newBlog);
      // Fetch all blogs again after adding
      getAllBlogs();
    } catch (error) {
      emit(BlogErrorState(state.blogs, error.toString()));
    }
  }

  // Delete a blog
  void deleteBlog(String blogId) async {
    emit(BlogLoadingState(blogs: state.blogs));

    try {
      await _blogRepository.deleteBlog(blogId);
      // Fetch all blogs again after deleting
      getAllBlogs();
    } catch (error) {
      emit(BlogErrorState(state.blogs, error.toString()));
    }
  }
}
