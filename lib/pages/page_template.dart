import 'package:flutter/material.dart';
import 'package:painel/components/comp_appbar.dart';
import 'package:painel/globals.dart';
import '../components/comp_menupath.dart';

class PageTemplate extends StatelessWidget {
  final String title;
  final List<Map<String, String>> breadcrumb;
  final Widget child;

  const PageTemplate({
    super.key,
    required this.title,
    required this.breadcrumb,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: globalAppBarTitle),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MenuPath(paths: breadcrumb),
              const SizedBox(height: 32),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 24),

              // Espaço reservado para o conteúdo da página
              child,

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}
