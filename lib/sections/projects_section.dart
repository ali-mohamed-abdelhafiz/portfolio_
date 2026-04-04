import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  List<dynamic> _projects = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://api.github.com/users/ali-mohamed-abdelhafiz/repos?sort=updated',
        ),
      );
      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            _projects = json.decode(response.body);
            // Filter out forks if desired, or just take top 6
            _projects = _projects
                .where((p) => p['fork'] == false)
                .take(6)
                .toList();
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _error = 'Failed to load projects';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 600;

    return Container(
      width: double.infinity,
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.1,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Some Things I\'ve Built',
                          style: Theme.of(
                            context,
                          ).textTheme.displayMedium?.copyWith(fontSize: 28),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: Theme.of(
                            context,
                          ).primaryColor.withValues(alpha: 0.3),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        Flexible(
                          child: Text(
                            'Some Things I\'ve Built',
                            style: Theme.of(
                              context,
                            ).textTheme.displayMedium?.copyWith(fontSize: 36),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.3),
                          ),
                        ),
                      ],
                    ))
              .animate()
              .fade(duration: 600.ms)
              .slideX(begin: -0.1),
          const SizedBox(height: 48),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(child: Text('Error: $_error'))
          else
            LayoutBuilder(
              builder: (context, constraints) {
                int crossAxisCount = isMobile
                    ? 1
                    : (constraints.maxWidth > 900 ? 3 : 2);
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
                  itemCount: _projects.length,
                  itemBuilder: (context, index) {
                    final project = _projects[index];
                    return ProjectCard(project: project)
                        .animate(delay: (100 * index).ms)
                        .fade()
                        .slideY(begin: 0.2);
                  },
                );
              },
            ),
          const SizedBox(height: 48),
          Center(
            child: ElevatedButton.icon(
              onPressed: () async {
                final uri = Uri.parse(
                  'https://github.com/AliMoo-space',
                );
                try {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                } catch (e) {
                  debugPrint('Could not launch $uri');
                }
              },
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
    );
  }
}

class ProjectCard extends StatefulWidget {
  final dynamic project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri);
    } catch (e) {
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
          if (widget.project['html_url'] != null) {
            _launchURL(widget.project['html_url']);
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
                      color: Theme.of(
                        context,
                      ).primaryColor.withValues(alpha: 0.2),
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
              color: isHovered
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
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
                  if (widget.project['html_url'] != null)
                    IconButton(
                      icon: const Icon(Icons.open_in_new),
                      color: isHovered ? Theme.of(context).primaryColor : null,
                      onPressed: () => _launchURL(widget.project['html_url']),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                widget.project['name'] ?? 'Project Name',
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
                  widget.project['description'] ?? 'No description provided.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 16),
              if (widget.project['language'] != null)
                Text(
                  widget.project['language'],
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
