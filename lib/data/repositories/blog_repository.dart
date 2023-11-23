import 'package:assignment12_front_end/core/api.dart';
import 'package:assignment12_front_end/data/models/blog/blog_model.dart';
import 'package:dio/dio.dart';

class BlogRepository {
  final _api = Api();

  Future<List<BlogModel>> fetchAllBlogs() async {
    try {
      Response response = await _api.sendRequest.get('/blogs');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => BlogModel.fromJson(json))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<BlogModel> fetchBlogById(String blogId) async {
    try {
      Response response = await _api.sendRequest.get('/blogs/$blogId');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return BlogModel.fromJson(apiResponse.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateBlog(BlogModel updatedBlog, String blogId) async {
    try {
      // Assume you have a method to convert BlogModel to JSON
      Map<String, dynamic> blogJson = updatedBlog.toJson();
      Response response =
          await _api.sendRequest.put('/blogs/$blogId', data: blogJson);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addBlog(BlogModel newBlog) async {
    try {
      // Assume you have a method to convert BlogModel to JSON
      Map<String, dynamic> blogJson = newBlog.toJson();

      Response response = await _api.sendRequest.post('/blogs', data: blogJson);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteBlog(String blogId) async {
    try {
      Response response = await _api.sendRequest.delete('/blogs/$blogId');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }
}
