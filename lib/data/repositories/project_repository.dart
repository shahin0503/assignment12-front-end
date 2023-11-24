import 'package:assignment12_front_end/core/api.dart';
import 'package:assignment12_front_end/data/models/project/project_model.dart';
import 'package:dio/dio.dart';

class ProjectRepository {
  final _api = Api();

  Future<List<ProjectModel>> fetchProjectByUser(String userId) async {
    try {
      Response response = await _api.sendRequest.get('/users/$userId/projects');

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
      return (apiResponse.data as List<dynamic>)
          .map((json) => ProjectModel.fromJson(json))
          .toList();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProject(ProjectModel newProject) async {
    try {
      Map<String, dynamic> projectJson = newProject.toJson();

      Response response =
          await _api.sendRequest.post('/projects', data: projectJson);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProject(
      ProjectModel updatedProject, String projectId) async {
    try {
      Map<String, dynamic> projectJson = updatedProject.toJson();
      Response response =
          await _api.sendRequest.put('/projects/$projectId', data: projectJson);

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteProject(String projectId) async {
    try {
      Response response = await _api.sendRequest.delete(
        '/projects/$projectId',
      );

      ApiResponse apiResponse = ApiResponse.fromResponse(response);

      if (!apiResponse.success) {
        throw apiResponse.message.toString();
      }
    } catch (error) {
      rethrow;
    }
  }
}
