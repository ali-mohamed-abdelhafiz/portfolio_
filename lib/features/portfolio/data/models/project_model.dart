import 'package:equatable/equatable.dart';

class ProjectModel extends Equatable {
  final String name;
  final String description;
  final String? language;
  final String htmlUrl;
  final bool fork;

  const ProjectModel({
    required this.name,
    required this.description,
    this.language,
    required this.htmlUrl,
    required this.fork,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      name: json['name'] as String? ?? 'Unknown Project',
      description: json['description'] as String? ?? '',
      language: json['language'] as String?,
      htmlUrl: json['html_url'] as String? ?? '',
      fork: json['fork'] as bool? ?? false,
    );
  }

  @override
  List<Object?> get props => [name, description, language, htmlUrl, fork];
}
