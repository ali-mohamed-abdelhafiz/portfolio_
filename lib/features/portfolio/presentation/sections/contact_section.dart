import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri)) {
        debugPrint('Could not launch $url');
      }
    } catch (e) {
      debugPrint('Could not launch $url');
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent successfully! (Demo)')),
      );
      _nameController.clear();
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 800;

    return Container(
      width: double.infinity,
      color: Theme.of(context).cardColor.withValues(alpha: 0.5),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : size.width * 0.1,
        vertical: 100,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Get In Touch',
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ).animate().fade(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 24),
          SizedBox(
            width: isMobile ? double.infinity : 600,
            child: Text(
              "I'm currently looking for new opportunities. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: isMobile ? 16 : 18,
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
          ).animate(delay: 200.ms).fade(duration: 600.ms).slideY(begin: 0.1),
          const SizedBox(height: 48),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 48,
            runSpacing: 48,
            children: [
              // Contact Links
              SizedBox(
                width: isMobile ? double.infinity : 300,
                child: Column(
                  children: [
                    ContactButton(
                      icon: FontAwesomeIcons.phone,
                      text: 'Phone',
                      onTap: () => _launchURL('tel:+201551713043'),
                    ),
                    const SizedBox(height: 16),
                    ContactButton(
                      icon: FontAwesomeIcons.linkedinIn,
                      text: 'LinkedIn',
                      onTap: () => _launchURL('https://www.linkedin.com/in/ali-mohamed-950215286/?isSelfProfile=true'),
                    ),
                    const SizedBox(height: 16),
                    ContactButton(
                      icon: FontAwesomeIcons.github,
                      text: 'GitHub',
                      onTap: () => _launchURL('https://github.com/ali-mohamed-abdelhafiz?tab=repositories'),
                    ),
                  ],
                ),
              ).animate(delay: 400.ms).fade(duration: 600.ms).slideX(begin: -0.1),

              // Contact Form
              SizedBox(
                width: isMobile ? double.infinity : 400,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _messageController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your message';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Send Message'),
                        ),
                      ),
                    ],
                  ),
                ),
              ).animate(delay: 400.ms).fade(duration: 600.ms).slideX(begin: 0.1),
            ],
          ),
        ],
      ),
    );
  }
}

class ContactButton extends StatefulWidget {
  final dynamic icon;
  final String text;
  final VoidCallback onTap;

  const ContactButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: isHovered ? Theme.of(context).primaryColor : Colors.transparent,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: isHovered
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
                      offset: const Offset(0, 8),
                      blurRadius: 16,
                    )
                  ]
                : [],
          ),
          transform: isHovered ? Matrix4.translationValues(0.0, -4.0, 0.0) : Matrix4.identity(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                widget.icon,
                color: isHovered ? Colors.white : Theme.of(context).primaryColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                widget.text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: isHovered ? Colors.white : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
