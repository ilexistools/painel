import 'dart:io';
import 'package:flutter/foundation.dart';

class JsonServerManager {
  static Process? _jsonServerProcess;
  static bool _isRunning = false;

  /// Inicia o json-server automaticamente (apenas em plataformas desktop)
  static Future<void> startJsonServer() async {
    // Só tenta iniciar o json-server em plataformas desktop
    if (kIsWeb) {
      print('JSON Server não pode ser iniciado na web. Execute manualmente:');
      print('json-server --watch db.json --port 3000');
      return;
    }

    if (_isRunning) {
      print('JSON Server já está rodando');
      return;
    }

    try {
      print('Iniciando JSON Server...');
      
      // Verifica se o arquivo db.json existe
      final dbFile = File('db.json');
      if (!await dbFile.exists()) {
        print('Erro: Arquivo db.json não encontrado');
        return;
      }

      // Inicia o json-server
      _jsonServerProcess = await Process.start(
        'json-server',
        ['--watch', 'db.json', '--port', '3000'],
        mode: ProcessStartMode.detached,
      );

      _isRunning = true;
      print('JSON Server iniciado na porta 3000');
      print('Acesse: http://localhost:3000/paineis');
      
      // Escuta a saída do processo para debug (opcional)
      _jsonServerProcess?.stdout.listen((data) {
        print('JSON Server: ${String.fromCharCodes(data)}');
      });

      _jsonServerProcess?.stderr.listen((data) {
        print('JSON Server Error: ${String.fromCharCodes(data)}');
      });

    } catch (e) {
      print('Erro ao iniciar JSON Server: $e');
      print('Certifique-se de que o json-server está instalado globalmente:');
      print('npm install -g json-server');
      print('');
      print('Para web, execute manualmente em um terminal separado:');
      print('json-server --watch db.json --port 3000');
    }
  }

  /// Para o json-server
  static Future<void> stopJsonServer() async {
    if (_jsonServerProcess != null && _isRunning) {
      _jsonServerProcess!.kill();
      _jsonServerProcess = null;
      _isRunning = false;
      print('JSON Server parado');
    }
  }

  /// Verifica se o json-server está rodando
  static bool get isRunning => _isRunning;
}

