
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaSelecionada = 0;

  // Paleta de cores Previ+
  static const Color deepLilac = Color(0xFF7E57C2);
  static const Color periwinkle = Color(0xFF9575CD);
  static const Color classicLavender = Color(0xFFB39DDB);
  static const Color paleLilac = Color(0xFFD1C4E9);
  static const Color lavenderMist = Color(0xFFF3E5F5);

  // Páginas da navegação
  final List<Widget> _paginas = [
    const InicioContent(),
    const PaginaProvisoria(
      titulo: 'Minha saúde',
      icone: Icons.favorite_outline,
    ),
    const PaginaProvisoria(
      titulo: 'Prevenção',
      icone: Icons.health_and_safety_outlined,
    ),
    const PaginaProvisoria(
      titulo: 'Agendamentos',
      icone: Icons.calendar_month_outlined,
    ),
    const PaginaProvisoria(
      titulo: 'Perfil',
      icone: Icons.person_outline,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: _paginas[_paginaSelecionada],
      ),

      // Navegação inferior
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
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Minha saúde',
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
// CONTEÚDO DA PÁGINA INICIAL

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

          // Cabeçalho
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

          // Cartão principal
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
                  onPressed: () {},
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

          // Acessos rápidos
          const Text(
            'Acessos rápidos',
            style: TextStyle(
              color: deepLilac,
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: const [
              Expanded(
                child: AtalhoCard(
                  titulo: 'Minha saúde',
                  descricao: 'Acompanhe seus dados',
                  icone: Icons.favorite_outline,
                ),
              ),

              SizedBox(width: 13),

              Expanded(
                child: AtalhoCard(
                  titulo: 'Prevenção',
                  descricao: 'Cuide-se diariamente',
                  icone: Icons.health_and_safety_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 13),

          Row(
            children: const [
              Expanded(
                child: AtalhoCard(
                  titulo: 'Agendamentos',
                  descricao: 'Consultas e exames',
                  icone: Icons.calendar_month_outlined,
                ),
              ),

              SizedBox(width: 13),

              Expanded(
                child: AtalhoCard(
                  titulo: 'Orientações',
                  descricao: 'Informações de saúde',
                  icone: Icons.menu_book_outlined,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          // Área informativa
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
        ],
      ),
    );
  }
}

// --------------------------------------------------
// CARTÕES DE ACESSO RÁPIDO
// --------------------------------------------------

class AtalhoCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final IconData icone;

  const AtalhoCard({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFFAF5FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFD1C4E9),
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icone,
            color: const Color(0xFF9575CD),
            size: 29,
          ),

          const SizedBox(height: 13),

          Text(
            titulo,
            style: const TextStyle(
              color: Color(0xFF7E57C2),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            descricao,
            style: const TextStyle(
              color: Color(0xFF55515A),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// --------------------------------------------------
// TELAS PROVISÓRIAS
// --------------------------------------------------

class PaginaProvisoria extends StatelessWidget {
  final String titulo;
  final IconData icone;

  const PaginaProvisoria({
    super.key,
    required this.titulo,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icone,
            color: const Color(0xFF9575CD),
            size: 65,
          ),

          const SizedBox(height: 15),

          Text(
            titulo,
            style: const TextStyle(
              color: Color(0xFF7E57C2),
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Em breve, novidades por aqui!',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
