
import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/agenda/agenda_screen.dart';
import '../screens/perfil/perfil_screen.dart';
import '../screens/prevencao/prevencao_screen.dart';
import '../screens/minha_saude/ciclo_screen.dart';

class AppRoutes {
  // Nomes das rotas
  static const String inicio = '/';
  static const String agenda = '/agenda';
  static const String perfil = '/perfil';
  static const String prevencao = '/prevencao';
  static const String minhaSaude = '/minha-saude';

  // Mapeamento das telas
  static Map<String, WidgetBuilder> routes = {
    inicio: (context) => const HomeScreen(),
    agenda: (context) => const AgendaScreen(),
    perfil: (context) => const PerfilScreen(),
    prevencao: (context) => const PrevencaoScreen(),
    minhaSaude: (context) => const CicloScreen(),
  };
}
