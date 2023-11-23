import 'package:assignment12_front_end/core/api.dart';
import 'package:assignment12_front_end/data/models/comment/comment_model.dart';
import 'package:dio/dio.dart';

class CommentRepository {
  final _api = Api();

  Future<void> addComment(CommentModel newComment) async {
    try {
      Map<String, dynamic> blogJson = newComment.toJson();

      Response response =
          await _api.sendRequest.post('/comments', data: blogJson);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<List<CommentModel>> getCommentsForBlog(String blogId) async {
    try {
      Response response = await _api.sendRequest.get('/blogs/$blogId');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }

      return (apiResponse.data['comments'] as List<dynamic>)
          .map((json) => CommentModel.fromJson(json))
          .toList();
    } catch (error) {
      rethrow;
    }
  }
}
