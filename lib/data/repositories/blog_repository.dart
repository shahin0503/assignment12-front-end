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

  }
