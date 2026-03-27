import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../sections/hero_section.dart';
import '../sections/about_section.dart';
import '../sections/skills_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NavBar(
              onHeroTap: () => _scrollTo(_heroKey),
              onAboutTap: () => _scrollTo(_aboutKey),
              onSkillsTap: () => _scrollTo(_skillsKey),
              onProjectsTap: () => _scrollTo(_projectsKey),
              onContactTap: () => _scrollTo(_contactKey),
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    HeroSection(
                      key: _heroKey,
                      onCheckOutTap: () => _scrollTo(_projectsKey),
                    ),
                    AboutSection(key: _aboutKey),
                    SkillsSection(key: _skillsKey),
                    ProjectsSection(key: _projectsKey),
                    ContactSection(key: _contactKey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
