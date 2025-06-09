import 'package:go_router/go_router.dart';
import 'package:painel/pages/page_sondagem.dart';

import 'pages/page_chartbar.dart';
import 'pages/page_chartline.dart';
import 'pages/page_home.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/painel/sondagem',
      builder: (context, state) => const SondagemPage(),
    ),
    GoRoute(
      path: '/line',
      builder: (context, state) => const ChartLinePage(),
    ),
    GoRoute(
      path: '/bar',
      builder: (context, state) => const ChartBarPage(),
    ),
  ],
);
