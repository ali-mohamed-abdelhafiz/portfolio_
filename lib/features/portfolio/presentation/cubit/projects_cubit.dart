import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/projects_repository.dart';
import 'projects_state.dart';

class ProjectsCubit extends Cubit<ProjectsState> {
  final ProjectsRepository repository;

  ProjectsCubit({required this.repository}) : super(ProjectsInitial());

  Future<void> fetchProjects() async {
    emit(ProjectsLoading());
    try {
      final projects = await repository.fetchProjects();
      emit(ProjectsLoaded(projects: projects));
    } catch (e) {
      emit(ProjectsError(message: e.toString()));
    }
  }
}
