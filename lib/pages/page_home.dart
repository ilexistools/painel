import 'package:flutter/material.dart';
import 'package:painel/components/comp_appbar.dart';
import 'package:painel/globals.dart';
import '../components/comp_menupath.dart';
import '../components/comp_panels.dart';


final breadcrumb = [
  {"title": "Home",    "route": "/"},
  {"title": "Painéis", "route": "/"},
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              const Text(
                'PAINÉIS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(height: 24),

              // 👇 Aqui o grid fica centralizado horizontalmente
              const Center(
                child: PanelsGrid(highlightedPanel: 'Educação'),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
    );
  }
}