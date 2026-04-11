import '../../../../core/api/dio_client.dart';
import '../models/project_model.dart';
import '../../../../core/api/api_exceptions.dart';

class ProjectsRepository {
  final DioClient dioClient;

  ProjectsRepository({required this.dioClient});

  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final response = await dioClient.get('users/AliMoo-space/repos?sort=updated');
      
      final data = response.data;
      if (data is List) {
        return data
            .map((json) => ProjectModel.fromJson(json))
            .where((project) => !project.fork)
            .take(6)
            .toList();
      } else {
        throw ApiException('Unexpected response format from GitHub API.');
      }
    } catch (e) {
      rethrow;
    }
  }
}
