import 'package:flutter/material.dart';
import 'package:previ/screens/hospitais/hospitais_screen.dart';
import 'package:previ/screens/agenda/agenda_screen.dart';
import 'package:previ/screens/perfil/perfil_screen.dart';
import 'package:previ/screens/prevencao/prevencao_screen.dart';
import 'package:previ/screens/minha_saude/ciclo_screen.dart';
import 'package:previ/widgets/atalho_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaSelecionada = 0;

  static const Color deepLilac = Color(0xFF7E57C2);

  final List<Widget> _paginas = [
    const InicioContent(),
    const CicloScreen(),
    const PrevencaoScreen(),
    const AgendaScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: _paginas[_paginaSelecionada],
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _paginaSelecionada,

        onTap: (index) {
          setState(() {
            _paginaSelecionada = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: deepLilac,
        unselectedItemColor: Colors.grey.shade500,
        selectedFontSize: 12,
        unselectedFontSize: 11,
        elevation: 10,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
        BottomNavigationBarItem(
          icon: Icon(Icons.water_drop_outlined),
          activeIcon: Icon(Icons.water_drop),
          label: 'Ciclo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.health_and_safety_outlined),
            activeIcon: Icon(Icons.health_and_safety),
            label: 'Prevenção',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// CONTEÚDO DA PÁGINA INICIAL
// --------------------------------------------------

class InicioContent extends StatelessWidget {
  const InicioContent({super.key});

  static const Color deepLilac = Color(0xFF7E57C2);
  static const Color periwinkle = Color(0xFF9575CD);
  static const Color lavenderMist = Color(0xFFF3E5F5);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // CABEÇALHO

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá, seja bem-vinda!',
                    style: TextStyle(
                      color: deepLilac,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    'Cuide de você. Sua saúde importa.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: lavenderMist,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: deepLilac,
                  size: 27,
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          // CARTÃO PRINCIPAL

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  deepLilac,
                  periwinkle,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 30,
                ),

                const SizedBox(height: 17),

                const Text(
                  'Sua saúde em primeiro lugar!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 9),

                const Text(
                  'A prevenção é um gesto de cuidado '
                      'com você mesma. Acompanhe sua saúde '
                      'e mantenha seus exames em dia.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 18),

                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const PrevencaoScreen(),
                      ),
                    );
                  },

                  style: OutlinedButton.styleFrom(
                    foregroundColor: deepLilac,
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),

                  child: const Text(
                    'Conheça os cuidados',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // ACESSOS RÁPIDOS

          const Text(
            'Acessos rápidos',
            style: TextStyle(
              color: deepLilac,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),

          // PRIMEIRA LINHA

          Row(
            children: [
              Expanded(
                child: AtalhoCard(
                  titulo: 'Minha saúde',
                  descricao: 'Acompanhe seus dados',
                  icone: Icons.favorite_outline,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const CicloScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: AtalhoCard(
                  titulo: 'Prevenção',
                  descricao: 'Cuide-se diariamente',
                  icone: Icons.health_and_safety_outlined,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const PrevencaoScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          // SEGUNDA LINHA

          Row(
            children: [
              Expanded(
                child: AtalhoCard(
                  titulo: 'Agendamentos',
                  descricao: 'Consultas e exames',
                  icone: Icons.calendar_month_outlined,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const AgendaScreen(),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: AtalhoCard(
                  titulo: 'Orientações',
                  descricao: 'Informações de saúde',
                  icone: Icons.menu_book_outlined,

                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                        const PrevencaoScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // ÁREA INFORMATIVA

          const Text(
            'Fique por dentro',
            style: TextStyle(
              color: deepLilac,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFFAF5FB),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFD1C4E9),
              ),
            ),

            child: Row(
              children: [
                const Icon(
                  Icons.lightbulb_outline,
                  color: periwinkle,
                  size: 35,
                ),

                const SizedBox(width: 14),

                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Não deixe a prevenção para depois!',
                        style: TextStyle(
                          color: deepLilac,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        'Mantenha seus exames e consultas '
                            'preventivas em dia.',
                        style: TextStyle(
                          color: Color(0xFF55515A),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          AtalhoCard(
            titulo: 'Hospitais próximos',
            descricao: 'Encontre unidades de saúde',
            icone: Icons.local_hospital_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HospitaisScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}