import 'dart:convert';
import 'package:http/http.dart' as http;

/// Modelo de dados para um painel
class PainelModel {
  final String title;
  final String tip;
  final int order;

  const PainelModel({
    required this.title,
    required this.tip,
    required this.order,
  });

  /// Cria um PainelModel a partir de um Map JSON
  factory PainelModel.fromJson(Map<String, dynamic> json) {
    return PainelModel(
      title: json['title'] ?? '',
      tip: json['tip'] ?? '',
      order: json['order'] ?? 0,
    );
  }

  /// Converte o PainelModel para Map JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'tip': tip,
      'order': order,
    };
  }
}

/// Serviço para carregar dados dos painéis do JSON Server
class PainelService {
  static const String baseUrl = 'http://localhost:3000';

  /// Carrega a lista de painéis do JSON Server
  static Future<List<PainelModel>> carregarPaineis() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/paineis'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final paineis = jsonList
            .map((json) => PainelModel.fromJson(json))
            .toList();
        
        // Ordena por order
        paineis.sort((a, b) => a.order.compareTo(b.order));
        
        return paineis;
      } else {
        throw Exception('Erro ao carregar painéis: ${response.statusCode}');
      }
    } catch (e) {
      // Em caso de erro, retorna lista padrão
      print('Erro ao conectar com JSON Server: $e');
      return _paineisPadrao();
    }
  }

  /// Lista de painéis padrão (fallback)
  static List<PainelModel> _paineisPadrao() {
    return [
      const PainelModel(
        title: 'METAS',
        tip: 'Metas estabelecidas',
        order: 1,
      ),
      const PainelModel(
        title: 'PEA',
        tip: 'Projetos das unidades',
        order: 2,
      ),
      const PainelModel(
        title: 'SONDAGEM',
        tip: 'Resultados da sondagem educacional',
        order: 3,
      ),
      const PainelModel(
        title: 'IDEB',
        tip: 'Índice de Desenvolvimento da Educação Básica',
        order: 4,
      ),
    ];
  }
}

