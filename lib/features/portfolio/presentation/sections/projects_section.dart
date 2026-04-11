import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/di/injection.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';
import '../../data/models/project_model.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  Future<void> _openAllProjects() async {
    final uri = Uri.parse('https://github.com/AliMoo-space?tab=repositories');
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return BlocProvider(
      create: (context) => sl<ProjectsCubit>()..fetchProjects(),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 24 : size.width * 0.1,
          vertical: 80,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isMobile),
            const SizedBox(height: 48),
            BlocBuilder<ProjectsCubit, ProjectsState>(
              builder: (context, state) {
                if (state is ProjectsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProjectsError) {
                  return _buildErrorState(context, state.message);
                } else if (state is ProjectsLoaded) {
                  return _buildProjectsGrid(context, state.projects, isMobile);
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 48),
            Center(
              child: ElevatedButton.icon(
                onPressed: _openAllProjects,
                icon: const Icon(Icons.code),
                label: const Text('View All Projects on GitHub'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
              ).animate(delay: 500.ms).fade().slideY(begin: 0.2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return (isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Some Things I\'ve Built',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                  ),
                ],
              )
            : Row(
                children: [
                  Flexible(
                    child: Text(
                      'Some Things I\'ve Built',
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(fontSize: 36),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ))
        .animate()
        .fade(duration: 600.ms)
        .slideX(begin: -0.1);
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error_outline, size: 48, color: Theme.of(context).colorScheme.error),
          const SizedBox(height: 16),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () => context.read<ProjectsCubit>().fetchProjects(),
            icon: const Icon(Icons.refresh),
            label: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context, List<ProjectModel> projects, bool isMobile) {
    if (projects.isEmpty) {
      return const Center(child: Text('No projects found.'));
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = isMobile ? 1 : (constraints.maxWidth > 900 ? 3 : 2);
        double childAspectRatio = isMobile ? 1.2 : 1.1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            final project = projects[index];
            return ProjectCard(project: project)
                .animate(delay: (100 * index).ms)
                .fade()
                .slideY(begin: 0.2);
          },
        );
      },
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          if (widget.project.htmlUrl.isNotEmpty) {
            _launchURL(widget.project.htmlUrl);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                      offset: const Offset(0, 10),
                      blurRadius: 30,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      offset: const Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
            border: Border.all(
              color: isHovered ? Theme.of(context).primaryColor : Colors.transparent,
              width: 2,
            ),
          ),
          transform: isHovered
              ? Matrix4.translationValues(0.0, -8.0, 0.0)
              : Matrix4.identity(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.folder_open,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  if (widget.project.htmlUrl.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.open_in_new),
                      color: isHovered ? Theme.of(context).primaryColor : null,
                      onPressed: () => _launchURL(widget.project.htmlUrl),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                widget.project.name,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20,
                      color: isHovered ? Theme.of(context).primaryColor : null,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Text(
                  widget.project.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                      ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              if (widget.project.language != null)
                Text(
                  widget.project.language!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontFamily: 'monospace',
                        color: Theme.of(context).primaryColor,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
