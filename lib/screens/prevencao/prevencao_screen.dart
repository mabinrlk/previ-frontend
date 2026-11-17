
import 'package:flutter/material.dart';

class PrevencaoScreen extends StatelessWidget {
  const PrevencaoScreen({super.key});

  static const Color roxo = Color(0xFF7E57C2);
  static const Color lilas = Color(0xFF9575CD);
  static const Color lilasClaro = Color(0xFFF3E5F5);
  static const Color textoEscuro = Color(0xFF4A148C);

  Widget _tituloSecao(String titulo, String subtitulo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textoEscuro,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitulo,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _cartaoConteudo({
    required IconData icone,
    required String titulo,
    required String descricao,
    required List<String> orientacoes,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: lilasClaro,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icone,
            color: roxo,
            size: 24,
          ),
        ),
        title: Text(
          titulo,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: textoEscuro,
          ),
        ),
        subtitle: Text(
          descricao,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        iconColor: roxo,
        collapsedIconColor: lilas,
        children: orientacoes.map((orientacao) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: lilas,
                  size: 18,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    orientacao,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Color(0xFF555555),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _cartaoDestaque() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF7E57C2),
            Color(0xFF9575CD),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(height: 14),
          const Text(
            'Cuidar de você também é prevenção!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Conhecimento e acompanhamento de saúde são aliados importantes para o cuidado feminino.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Sua saúde merece atenção todos os dias.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _avisoImportante() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFFFE082),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFFB7791F),
            size: 23,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'As informações deste aplicativo são educativas e não substituem uma consulta. A indicação e a frequência dos exames devem ser avaliadas por um profissional de saúde.',
              style: TextStyle(
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF795548),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Prevenção'),
        backgroundColor: const Color(0xFF7E57C2),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Destaque principal
            _cartaoDestaque(),

            const SizedBox(height: 28),

            // Saúde das mamas
            _tituloSecao(
              'Saúde das mamas',
              'Conheça seu corpo e saiba quais cuidados são importantes.',
            ),

            const SizedBox(height: 14),

            _cartaoConteudo(
              icone: Icons.health_and_safety_outlined,
              titulo: 'Conheça suas mamas',
              descricao: 'Atenção às mudanças no seu corpo',
              orientacoes: [
                'Conhecer o aspecto habitual das próprias mamas ajuda a perceber alterações.',
                'Observe mudanças no formato, tamanho, pele ou mamilo.',
                'Procure avaliação profissional se perceber alguma alteração persistente ou incomum.',
              ],
            ),

            _cartaoConteudo(
              icone: Icons.medical_services_outlined,
              titulo: 'Mamografia',
              descricao: 'Entenda a importância do exame',
              orientacoes: [
                'A mamografia é um exame de imagem utilizado para identificar alterações nas mamas.',
                'A recomendação de realização depende da idade, do histórico individual e das orientações de saúde vigentes.',
                'Converse com um profissional para saber quando o exame é indicado para você.',
              ],
            ),

            const SizedBox(height: 18),

            // Saúde do colo do útero
            _tituloSecao(
              'Saúde do colo do útero',
              'Informações sobre prevenção, vacinação e acompanhamento.',
            ),

            const SizedBox(height: 14),

            _cartaoConteudo(
              icone: Icons.vaccines_outlined,
              titulo: 'HPV e vacinação',
              descricao: 'Saiba como a vacina ajuda na prevenção',
              orientacoes: [
                'O HPV é um vírus que pode causar alterações celulares e alguns tipos de câncer.',
                'A vacinação contra o HPV ajuda a prevenir infecções pelos tipos mais associados a doenças.',
                'Verifique a disponibilidade e as recomendações da vacina na unidade de saúde.',
              ],
            ),

            _cartaoConteudo(
              icone: Icons.assignment_outlined,
              titulo: 'Exame preventivo',
              descricao: 'Conheça o exame de rastreamento do colo do útero',
              orientacoes: [
                'O exame preventivo permite identificar alterações que podem anteceder o câncer do colo do útero.',
                'O rastreamento deve seguir as recomendações oficiais e considerar a faixa etária e o histórico da pessoa.',
                'Procure uma unidade de saúde para receber orientação sobre a realização do exame.',
              ],
            ),

            const SizedBox(height: 18),

            // Hábitos saudáveis
            _tituloSecao(
              'Hábitos saudáveis',
              'Pequenas atitudes também fazem parte do cuidado.',
            ),

            const SizedBox(height: 14),

            _cartaoConteudo(
              icone: Icons.restaurant_outlined,
              titulo: 'Alimentação equilibrada',
              descricao: 'Cuide da sua alimentação',
              orientacoes: [
                'Priorize alimentos naturais ou minimamente processados.',
                'Inclua frutas, verduras, legumes e outros alimentos variados na rotina.',
                'Mantenha uma alimentação equilibrada, respeitando suas necessidades individuais.',
              ],
            ),

            _cartaoConteudo(
              icone: Icons.directions_walk_outlined,
              titulo: 'Atividade física',
              descricao: 'Movimente-se e cuide do seu bem-estar',
              orientacoes: [
                'Procure incluir atividades físicas na rotina, de acordo com suas condições.',
                'Caminhadas, dança e outras atividades podem contribuir para a saúde.',
                'Respeite seus limites e procure orientação quando necessário.',
              ],
            ),

            _cartaoConteudo(
              icone: Icons.smoke_free_outlined,
              titulo: 'Evite o tabagismo',
              descricao: 'Reduza fatores de risco',
              orientacoes: [
                'Não fumar é uma atitude importante para a prevenção de diversos problemas de saúde.',
                'Evite também a exposição frequente à fumaça do cigarro.',
                'Se precisar de ajuda para parar de fumar, procure uma unidade de saúde.',
              ],
            ),

            const SizedBox(height: 18),

            // Sinais de alerta
            _tituloSecao(
              'Sinais de alerta',
              'Alterações que merecem atenção profissional.',
            ),

            const SizedBox(height: 14),

            _cartaoConteudo(
              icone: Icons.warning_amber_outlined,
              titulo: 'Alterações nas mamas',
              descricao: 'Fique atenta aos sinais',
              orientacoes: [
                'Caroço ou endurecimento novo na mama ou axila.',
                'Alterações na pele, como retração ou aspecto semelhante à casca de laranja.',
                'Saída espontânea de secreção pelo mamilo, especialmente com sangue.',
                'Mudanças recentes no formato ou posição do mamilo.',
                'Essas alterações nem sempre indicam câncer, mas precisam de avaliação.',
              ],
            ),

            _cartaoConteudo(
              icone: Icons.health_and_safety_outlined,
              titulo: 'Alterações ginecológicas',
              descricao: 'Quando procurar atendimento',
              orientacoes: [
                'Sangramento vaginal fora do período menstrual ou após a menopausa.',
                'Sangramento após relações sexuais.',
                'Dor pélvica persistente ou corrimento com alterações incomuns.',
                'Procure avaliação profissional para investigar a causa.',
              ],
            ),

            const SizedBox(height: 12),

            // Aviso educativo
            _avisoImportante(),

            const SizedBox(height: 24),

            const Center(
              child: Text(
                'Previ+ • Informação também é prevenção',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
