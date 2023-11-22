import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:assignment12_front_end/data/repositories/blog_repository.dart';
import 'package:assignment12_front_end/logic/cubits/blog_cubit/blog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogCubit extends Cubit<BlogState>{
  BlogCubit() : super(BlogInitialState()){
    _initialize();
  }

 final BlogRepository _blogRepository = BlogRepository();


  void _initialize() async {
    emit(BlogLoadingState(state.blogs));

    try {

      List<BlogModel> blogs =
          await _blogRepository.fetchAllBlogs();

      emit(BlogLoadedState(blogs));

    } catch (error) {
      
      emit(BlogErrorState(state.blogs, error.toString()));
    }
  }
}