import 'package:flutter/material.dart';
import 'package:painel/routes.dart'; // ajuste o path se necessário

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Painel',

      // Tema claro
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),

      // Tema escuro
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.tealAccent,
        ),
      ),

      // Usa o tema do sistema operacional (ou mude para .dark/.light se quiser fixo)
      themeMode: ThemeMode.dark,

      routerConfig: appRouter,
    );
  }
}
