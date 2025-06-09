import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

/// CustomPainter para desenhar o semicírculo (espessura e cores relativas)
class SemiCircleGaugePainter extends CustomPainter {
  final double percentage;
  final Color filledColor;
  final Color backgroundColor;
  final double strokeWidth;

  SemiCircleGaugePainter({
    required this.percentage,
    required this.filledColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Definimos o centro em (size.width/2, size.height), pois o size.height
    // será metade de size.width (graças ao AspectRatio 2:1 no widget)
    final Offset center = Offset(size.width / 2, size.height);
    final double radius = size.width / 2;

    // 1) Desenha o semicírculo de "fundo" em backgroundColor (cinza)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // começa em 180° (à esquerda embaixo)
      pi, // varre 180° → semicírculo superior
      false,
      backgroundPaint,
    );

    // 2) Desenha o semicírculo preenchido em filledColor (azul), proporcional a percentage
    final filledPaint = Paint()
      ..color = filledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweepFilled = pi * (percentage.clamp(0, 100) / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // mesma posição inicial (180°)
      sweepFilled, // varre só até percentage (ex: 0.74 * π)
      false,
      filledPaint,
    );
  }

  @override
  bool shouldRepaint(covariant SemiCircleGaugePainter old) {
    return old.percentage != percentage ||
        old.filledColor != filledColor ||
        old.backgroundColor != backgroundColor ||
        old.strokeWidth != strokeWidth;
  }
}

/// Widget responsivo para exibir o card com título, semicírculo e labels “0%–100%”
class CustomGauge extends StatelessWidget {
  final double percentage;

  const CustomGauge({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Cores “hardcode” (podem vir de Theme ou constantes)
    const Color fillColor = Color(0xFF3D82FF);
    const Color emptyColor = Color(0xFFE6E6E6);
    const Color cardBackground = Color(0xFFF5F5F7);

    // Formata a porcentagem com vírgula (ex: “74,0%”)
    final String formattedPct =
        '${NumberFormat.decimalPattern('pt_BR').format(percentage).replaceAll('\u00A0', '')}%';

    return LayoutBuilder(
      builder: (context, constraints) {
        // 1) Define largura do card como 90% da largura disponível do pai
        //    (se constraints.maxWidth for muito grande, você pode limitar até um valor máximo)
        double containerWidth = constraints.maxWidth * 0.9;

        // Se quiser impor um valor máximo absoluto (ex: não deixar passar de 300px):
        // containerWidth = min(containerWidth, 300);

        // 2) Agora podemos definir tamanhos relativos:
        //    - O semicírculo (AspectRatio 2:1) terá largura containerWidth * 0.8
        //      (80% da largura do card). O restante é margem interna.
        final double gaugeWidth = containerWidth * 0.8;
        //    - A altura será gaugeWidth / 2, via AspectRatio
        //    - strokeWidth do arco = 10% de gaugeWidth (ou qualquer proporção que você achar bom)
        final double strokeWidth = gaugeWidth * 0.1;

        //    - Espaçamento vertical entre título e semicírculo: 5% da containerWidth
        final double gapTitleToGauge = containerWidth * 0.05;

        //    - Padding horizontal para alinhar “0%” e “100%”:  (gaugeWidth * 0.1)
        final double labelsHorizontalPadding = gaugeWidth * 0.1;

        return Center(
          child: Container(
            width: containerWidth,
            padding: EdgeInsets.all(containerWidth * 0.048),
            // padding proporcional, ex: 4.8% da largura do card (~12px se containerWidth=250)
            decoration: BoxDecoration(
              color: cardBackground,
              borderRadius: BorderRadius.circular(containerWidth * 0.048),
              // borda arredondada proporcional (~12px se containerWidth=250)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ======== TÍTULO =========
                const Text(
                  'TAXA DE PARTICIPAÇÃO',
                  style: TextStyle(
                    color: Colors.black87,
                    // Aqui poderíamos deixar a fonte escalonar, mas normalmente 14 já vai bem
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: gapTitleToGauge),

                // ======== GAUGE (semicírculo) =========
                SizedBox(
                  width: gaugeWidth,
                  // Envolver em AspectRatio(2) garante rácio 2:1 → metade visível
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // CustomPaint que vai desenhar o semicírculo completo,
                        // mas só a metade superior aparecerá dentro da altura.
                        CustomPaint(
                          painter: SemiCircleGaugePainter(
                            percentage: percentage,
                            filledColor: fillColor,
                            backgroundColor: emptyColor,
                            strokeWidth: strokeWidth,
                          ),
                          // O CustomPaint “pinta” em toda a área de AspectRatio(2),
                          // que tem altura = gaugeWidth / 2
                        ),

                        // Texto central (ex: “74,0%”), posicionado no centro do semicírculo
                        Text(
                          formattedPct,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: gaugeWidth * 0.11,
                            // fontSize proporcional ao gaugeWidth (ex: 0.11*200=22)
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: gapTitleToGauge),

                // ======== LABELS “0%” e “100%” =========
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: labelsHorizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '0%',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: gaugeWidth * 0.055,
                          // ex: 0.055*200=11px
                        ),
                      ),
                      Text(
                        '100%',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: gaugeWidth * 0.055,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
