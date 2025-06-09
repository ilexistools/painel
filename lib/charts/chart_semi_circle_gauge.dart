import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart'; // Para formatar "74,0%"

/// CustomPainter que desenha o semicírculo (fundo cinza + preenchimento azul).
class SemiCircleGaugePainter extends CustomPainter {
  final double percentage; // de 0 a 100
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
    // Definimos o centro em (size.width/2, size.height) para que o semicírculo
    // caiba dentro de um box cuja altura seja exatamente o raio.
    final Offset center = Offset(size.width / 2, size.height);
    // Raio = size.width / 2 para que o diâmetro seja exatamente a largura
    final double radius = size.width / 2;

    // 1) Desenha o arco de "fundo" em cinza (180° = π radianos)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // ponto inicial (180°, à esquerda em baixo)
      pi, // sweep de π radianos (180°) → semicírculo superior
      false,
      backgroundPaint,
    );

    // 2) Desenha o arco "preenchido" em azul, proporcional à percentage
    final filledPaint = Paint()
      ..color = filledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweepFilled = pi * (percentage.clamp(0, 100) / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi, // mesmo ponto inicial (180°)
      sweepFilled, // só até a porcentagem (ex: 0.74 * π)
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

/// Widget que monta todo o cartão com título, semicírculo e labels.
class CustomGauge extends StatelessWidget {
  final double percentage;

  const CustomGauge({
    Key? key,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1) Cores (igual à sua referência)
    const Color fillColor = Color(0xFF3D82FF);
    const Color emptyColor = Color(0xFFE6E6E6);
    const Color cardBackground = Color(0xFFF5F5F7);

    // 2) Formata a porcentagem com vírgula (ex: “74,0%”)
    final String formatted = NumberFormat.decimalPattern('pt_BR')
            .format(percentage)
            .replaceAll('\u00A0', '') +
        '%';

    return Container(
      width: 250,
      // REMOVEMOS o height fixo para o Container se ajustar ao conteúdo
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta só ao que for necessário
        children: [
          // ======= TÍTULO =======
          const Text(
            'TAXA DE PARTICIPAÇÃO',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // ======= GAUGE =======
          // A ideia continua a mesma: um CustomPaint de 200×100 que desenha
          // um semicírculo de raio 100, mas só se vê a metade de cima.
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 100,
                child: CustomPaint(
                  painter: SemiCircleGaugePainter(
                    percentage: percentage,
                    filledColor: fillColor,
                    backgroundColor: emptyColor,
                    strokeWidth: 20, // espessura do arco
                  ),
                ),
              ),
              Text(
                formatted,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ======= LABELS “0%” e “100%” =======
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '0%',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                Text(
                  '100%',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
