import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuPath extends StatelessWidget {
  final List<Map<String, String>> paths;

  const MenuPath({
    Key? key,
    required this.paths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Monta dinamicamente os itens + setas
    final children = <Widget>[];
    for (var i = 0; i < paths.length; i++) {
      final item = paths[i];
      final isLast = i == paths.length - 1;

      children.add(
        InkWell(
          onTap: () {
            // Navega para a rota do item
            context.go(item['route']!);
          },
          child: Text(
            item['title']!,
            style: TextStyle(
              color: isLast ? Colors.orange : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Se não for o último, adiciona a seta
      if (!isLast) {
        children.add(const SizedBox(width: 8));
        children.add(const Icon(
          Icons.chevron_right,
          color: Colors.orange,
          size: 20,
        ));
        children.add(const SizedBox(width: 8));
      }
    }

    return Row(children: children);
  }
}
