import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Dados de cada painel
class PanelData {
  final String title;
  final String tip;   // ainda declarado, mas não é mais usado
  final String route;
  final int order;

  const PanelData({
    required this.title,
    required this.tip,
    required this.route,
    required this.order,
  });
}

class PanelsGrid extends StatelessWidget {
  /// Nome do painel que deve aparecer destacado
  final String highlightedPanel;

  const PanelsGrid({
    Key? key,
    required this.highlightedPanel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panels = <PanelData>[
      const PanelData(
        title: 'METAS',
        tip: 'Metas estabelecidas',
        route: '/painel/metas',
        order: 1,
      ),
      const PanelData(
        title: 'PEA',
        tip: 'Projetos das unidades',
        route: '/painel/pea',
        order: 2,
      ),
      const PanelData(
        title: 'SONDAGEM',
        tip: 'Resultados da sondagem educacional',
        route: '/painel/sondagem',
        order: 3,
      ),
      const PanelData(
        title: 'IDEP',
        tip: 'Índice de Desenvolvimento da Educação Paulistana',
        route: '/painel/idep',
        order: 4,
      ),
      const PanelData(
        title: 'APROVAÇÃO',
        tip: 'Taxa de aprovação escolar',
        route: '/painel/aprovacao',
        order: 5,
      ),
      const PanelData(
        title: 'PAP',
        tip: 'Projeto de Acompanhamento Pedagógico',
        route: '/painel/pap',
        order: 6,
      ),
      const PanelData(
        title: 'IDEB',
        tip: 'Índice de Desenvolvimento da Educação Básica',
        route: '/painel/ideb',
        order: 7,
      ),
      const PanelData(
        title: 'AUSÊNCIA',
        tip: 'Ausência de docentes',
        route: '/painel/ausencia',
        order: 8,
      ),
      const PanelData(
        title: 'FREQUÊNCIA',
        tip: 'Frequência de estudantes',
        route: '/painel/frequencia',
        order: 9,
      ),
      const PanelData(
        title: 'ABANDONO',
        tip: 'Índice de evasão escolar',
        route: '/painel/abandono',
        order: 10,
      ),
      const PanelData(
        title: 'SGA',
        tip: 'Sistema de Gestão da Aprendizagem',
        route: '/painel/sga',
        order: 11,
      ),
      const PanelData(
        title: 'FORMAÇÕES',
        tip: 'Formações e cursos',
        route: '/painel/formacoes',
        order: 12,
      ),
    ]..sort((a, b) => a.order.compareTo(b.order)); // ordenação

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: panels.map((panel) {
        final isHighlighted = panel.title == highlightedPanel;
        return _PanelItem(
          data: panel,
          isHighlighted: isHighlighted,
        );
      }).toList(),
    );
  }
}

class _PanelItem extends StatefulWidget {
  final PanelData data;
  final bool isHighlighted;

  const _PanelItem({
    Key? key,
    required this.data,
    required this.isHighlighted,
  }) : super(key: key);

  @override
  State<_PanelItem> createState() => _PanelItemState();
}

class _PanelItemState extends State<_PanelItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    // cor azul‑claro para hover e destaque
    const hoverColor = Color.fromRGBO(75, 193, 234, 1);

    // fundo e texto conforme hover/destaque
    final backgroundColor =
        (widget.isHighlighted || _hovered) ? hoverColor : Colors.transparent;
    final textColor =
        (widget.isHighlighted || _hovered) ? Colors.black : Colors.cyan;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => GoRouter.of(context).go(widget.data.route),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 220,
          height: 160,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.cyan, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}
