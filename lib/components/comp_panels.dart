import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:painel/services/painel_service.dart';

/// Dados de cada painel (mantido para compatibilidade com rotas)
class PanelData {
  final String title;
  final String tip;
  final String route;
  final int order;

  const PanelData({
    required this.title,
    required this.tip,
    required this.route,
    required this.order,
  });

  /// Cria PanelData a partir de PainelModel, gerando rota automaticamente
  factory PanelData.fromPainelModel(PainelModel painel) {
    return PanelData(
      title: painel.title,
      tip: painel.tip,
      route: '/painel/${painel.title.toLowerCase()}',
      order: painel.order,
    );
  }
}

class PanelsGrid extends StatefulWidget {
  /// Nome do painel que deve aparecer destacado
  final String highlightedPanel;

  const PanelsGrid({
    Key? key,
    required this.highlightedPanel,
  }) : super(key: key);

  @override
  State<PanelsGrid> createState() => _PanelsGridState();
}

class _PanelsGridState extends State<PanelsGrid> {
  List<PanelData> _panels = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _carregarPaineis();
  }

  /// Carrega os painéis do JSON Server
  Future<void> _carregarPaineis() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final paineis = await PainelService.carregarPaineis();
      final panels = paineis
          .map((painel) => PanelData.fromPainelModel(painel))
          .toList();

      setState(() {
        _panels = panels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erro ao carregar painéis: $e';
        _isLoading = false;
        // Carrega painéis padrão em caso de erro
        _panels = _paineisPadrao();
      });
    }
  }

  /// Lista de painéis padrão (fallback)
  List<PanelData> _paineisPadrao() {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Carregando painéis...'),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'Usando dados padrão',
              style: TextStyle(color: Colors.orange),
            ),
            SizedBox(height: 8),
            Text(
              _error!,
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _carregarPaineis,
              child: Text('Tentar Novamente'),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Indicador de fonte dos dados
        Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_done,
                color: Colors.green,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Dados carregados do JSON Server (${_panels.length} painéis)',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Grid de painéis
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: _panels.map((panel) {
            final isHighlighted = panel.title == widget.highlightedPanel;
            return _PanelItem(
              data: panel,
              isHighlighted: isHighlighted,
            );
          }).toList(),
        ),
      ],
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
      onExit: (_) => setState(() => _hovered = false),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.data.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              if (widget.data.tip.isNotEmpty) ...[
                SizedBox(height: 8),
                Text(
                  widget.data.tip,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor.withOpacity(0.8),
                    fontSize: 12.0,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

