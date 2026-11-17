
import 'package:flutter/material.dart';

class HospitaisScreen extends StatefulWidget {
  const HospitaisScreen({super.key});

  @override
  State<HospitaisScreen> createState() => _HospitaisScreenState();
}

class _HospitaisScreenState extends State<HospitaisScreen> {
  final Color roxo = const Color(0xFF7E57C2);

  int hospitalSelecionado = 0;

  final List<Map<String, String>> hospitais = [
    {
      'nome': 'Hospital Santa Maria',
      'tipo': 'Hospital geral',
      'distancia': '1,2 km',
      'endereco': 'Rua das Flores, 120',
      'telefone': '(84) 3333-1000',
    },
    {
      'nome': 'Maternidade Esperança',
      'tipo': 'Maternidade',
      'distancia': '2,5 km',
      'endereco': 'Av. Central, 450',
      'telefone': '(84) 3333-2000',
    },
    {
      'nome': 'Centro de Saúde Vida',
      'tipo': 'Unidade de saúde',
      'distancia': '3,1 km',
      'endereco': 'Rua Primavera, 80',
      'telefone': '(84) 3333-3000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final hospital = hospitais[hospitalSelecionado];

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7FC),
      appBar: AppBar(
        title: const Text(
          'Hospitais próximos',
          style: TextStyle(
            color: Color(0xFF4A148C),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: roxo,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Encontre atendimento perto de você',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Veja algumas unidades de saúde disponíveis no mapa.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // MAPA ILUSTRATIVO
            Container(
              height: 330,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE8E9DD),
                borderRadius: BorderRadius.circular(22),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  // Ruas horizontais
                  Positioned(
                    top: 85,
                    left: -30,
                    child: _rua(420, 24, 12),
                  ),
                  Positioned(
                    top: 205,
                    left: -30,
                    child: _rua(420, 24, -8),
                  ),

                  // Ruas verticais
                  Positioned(
                    top: -40,
                    left: 85,
                    child: _rua(420, 22, 82),
                  ),
                  Positioned(
                    top: -40,
                    right: 75,
                    child: _rua(420, 22, 96),
                  ),

                  // Área verde
                  Positioned(
                    top: 15,
                    right: 15,
                    child: Container(
                      width: 85,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFC5D9B5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.park,
                          color: Color(0xFF648B59),
                          size: 30,
                        ),
                      ),
                    ),
                  ),

                  // Marcadores
                  _marcador(35, 115, 0),
                  _marcador(215, 45, 1),
                  _marcador(240, 225, 2),

                  // Localização fictícia da usuária
                  Positioned(
                    left: 145,
                    top: 150,
                    child: Column(
                      children: [
                        const Icon(
                          Icons.my_location,
                          color: Colors.blue,
                          size: 30,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Você',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Mapa ilustrativo',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Unidades de saúde',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 14),

            ...List.generate(hospitais.length, (index) {
              final item = hospitais[index];
              final selecionado = hospitalSelecionado == index;

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12),
                color: selecionado
                    ? const Color(0xFFF3E5F5)
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: selecionado
                        ? roxo
                        : const Color(0xFFE8DFF0),
                  ),
                ),
                child: ListTile(
                  onTap: () {
                    setState(() {
                      hospitalSelecionado = index;
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFFD1C4E9),
                    child: Icon(
                      Icons.local_hospital,
                      color: roxo,
                    ),
                  ),
                  title: Text(
                    item['nome']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    '${item['tipo']} • ${item['distancia']}',
                  ),
                  trailing: Icon(
                    selecionado
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: roxo,
                  ),
                ),
              );
            }),

            // Detalhes do hospital selecionado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFE8DFF0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hospital['nome']!,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: roxo,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _informacao(Icons.location_on, hospital['endereco']!),
                  const SizedBox(height: 10),
                  _informacao(Icons.phone, hospital['telefone']!),
                  const SizedBox(height: 10),
                  _informacao(Icons.near_me, hospital['distancia']!),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              '* Os estabelecimentos e endereços apresentados são fictícios.',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _rua(double largura, double altura, double rotacao) {
    return Transform.rotate(
      angle: rotacao * 3.14159 / 180,
      child: Container(
        width: largura,
        height: altura,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _marcador(double left, double top, int index) {
    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () {
          setState(() {
            hospitalSelecionado = index;
          });
        },
        child: Icon(
          Icons.location_on,
          color: hospitalSelecionado == index
              ? const Color(0xFF7E57C2)
              : const Color(0xFF9575CD),
          size: 42,
        ),
      ),
    );
  }

  Widget _informacao(IconData icone, String texto) {
    return Row(
      children: [
        Icon(icone, color: const Color(0xFF7E57C2), size: 20),
        const SizedBox(width: 10),
        Expanded(child: Text(texto)),
      ],
    );
  }
}
