import 'package:flutter/material.dart';
import 'page_template.dart';

final breadcrumb = [
  {"title": "Home",    "route": "/"},
  {"title": "Painéis", "route": "/"},
  {"title": "SONDAGEM", "route": "/painel/sondagem"},
];

class SondagemPage extends StatelessWidget {
  const SondagemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      title: 'SONDAGEM',
      breadcrumb: breadcrumb,
      child: const Center(
        // Aqui vai o conteúdo da página
        child:Text('Funcionando!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.cyan,
          ),
        ),
      ),
    );
  }
}
