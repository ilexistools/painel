import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

/// CustomPainter que desenha o semicírculo:
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
    final Offset center = Offset(size.width / 2, size.height);
    final double radius = size.width / 2;

    // Arco de fundo (cinza)
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      pi,
      false,
      backgroundPaint,
    );

    // Arco preenchido (azul)
    final filledPaint = Paint()
      ..color = filledColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double sweepFilled = pi * (percentage.clamp(0, 100) / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      pi,
      sweepFilled,
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

/// Widget que exibe o card com título, arco e rótulos “0%–100%”:
class CustomGauge extends StatelessWidget {
  final double percentage;
  const CustomGauge({Key? key, required this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color fillColor = Color(0xFF3D82FF);
    const Color emptyColor = Color(0xFFE6E6E6);
    const Color cardBackground = Color(0xFFF5F5F7);

    final String formattedPct = NumberFormat.decimalPattern('pt_BR')
            .format(percentage)
            .replaceAll('\u00A0', '') +
        '%';

    return Container(
      width: 250,
      // Se quiser container ajustando-se ao conteúdo, remova o height fixo:
      // height: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // faz a coluna “encolher” ao conteúdo
        children: [
          // ======== TÍTULO =========
          const Text(
            'TAXA DE PARTICIPAÇÃO',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Aumentamos o espaçamento de 8 para 16 pixels
          const SizedBox(height: 16),

          // ======== GAUGE =========
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
                    strokeWidth: 20,
                  ),
                ),
              ),
              // Texto central “74%” (ou outra porcentagem)
              Text(
                formattedPct,
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          // ======== LABELS “0%” e “100%” ========
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
