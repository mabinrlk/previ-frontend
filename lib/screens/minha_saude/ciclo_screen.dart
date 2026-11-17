
import 'package:flutter/material.dart';

class CicloScreen extends StatefulWidget {
  const CicloScreen({super.key});

  @override
  State<CicloScreen> createState() => _CicloScreenState();
}

class _CicloScreenState extends State<CicloScreen> {

  // PALETA OFICIAL PREVI+
  static const Color deepLilac = Color(0xFF7E57C2);
  static const Color periwinkle = Color(0xFF9575CD);
  static const Color classicLavender = Color(0xFFB39DDB);
  static const Color paleLilac = Color(0xFFD1C4E9);
  static const Color lavenderMist = Color(0xFFF3E5F5);

  // CORES COMPLEMENTARES
  static const Color texto = Color(0xFF333333);
  static const Color branco = Colors.white;
  static const Color rosaMenstruacao = Color(0xFFF4B8CB);

  DateTime mesAtual = DateTime.now();

  DateTime? inicioMenstruacao;
  DateTime? fimMenstruacao;

  final List<DateTime> historicoCiclos = [];
  final Set<DateTime> diasMenstruacao = {};
  final Set<String> sintomasSelecionados = {};

  final List<String> sintomas = [
    'Cólicas',
    'Dor de cabeça',
    'Inchaço',
    'Acne',
    'Cansaço',
    'Ansiedade',
    'Irritabilidade',
    'Sensibilidade nos seios',
  ];

  DateTime normalizarData(DateTime data) {
    return DateTime(data.year, data.month, data.day);
  }

  bool mesmaData(DateTime a, DateTime b) {
    return a.year == b.year &&
        a.month == b.month &&
        a.day == b.day;
  }

  int get duracaoCiclo {
    if (historicoCiclos.length < 2) return 28;

    final duracoes = <int>[];

    for (int i = 1; i < historicoCiclos.length; i++) {
      duracoes.add(
        historicoCiclos[i]
            .difference(historicoCiclos[i - 1])
            .inDays,
      );
    }

    return (duracoes.reduce((a, b) => a + b) /
        duracoes.length)
        .round();
  }

  DateTime? get proximaMenstruacao {
    if (historicoCiclos.isEmpty) return null;

    return historicoCiclos.last.add(
      Duration(days: duracaoCiclo),
    );
  }

  DateTime? get ovulacaoPrevista {
    if (proximaMenstruacao == null) return null;

    return proximaMenstruacao!.subtract(
      const Duration(days: 14),
    );
  }

  String formatarData(DateTime? data) {
    if (data == null) return '--/--';

    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}';
  }

  String nomeMes(int mes) {
    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];

    return meses[mes - 1];
  }

  Future<void> escolherInicio() async {
    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
      helpText: 'Primeiro dia da menstruação',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: deepLilac,
              onPrimary: branco,
              surface: branco,
              onSurface: texto,
            ),
          ),
          child: child!,
        );
      },
    );

    if (data == null) return;

    final dataEscolhida = normalizarData(data);

    setState(() {
      inicioMenstruacao = dataEscolhida;
      fimMenstruacao = null;

      if (!historicoCiclos.any(
            (d) => mesmaData(d, dataEscolhida),
      )) {
        historicoCiclos.add(dataEscolhida);
        historicoCiclos.sort((a, b) => a.compareTo(b));
      }

      diasMenstruacao.add(dataEscolhida);
    });
  }

  Future<void> escolherFim() async {
    if (inicioMenstruacao == null) {
      mostrarMensagem(
        'Registre primeiro o início da menstruação.',
      );
      return;
    }

    final data = await showDatePicker(
      context: context,
      initialDate: DateTime.now().isBefore(inicioMenstruacao!)
          ? inicioMenstruacao!
          : DateTime.now(),
      firstDate: inicioMenstruacao!,
      lastDate: DateTime(2035),
      helpText: 'Último dia da menstruação',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: deepLilac,
              onPrimary: branco,
              surface: branco,
              onSurface: texto,
            ),
          ),
          child: child!,
        );
      },
    );

    if (data == null) return;

    final fim = normalizarData(data);

    if (fim.difference(inicioMenstruacao!).inDays > 14) {
      mostrarMensagem('Confira a data informada.');
      return;
    }

    setState(() {
      fimMenstruacao = fim;

      DateTime dia = inicioMenstruacao!;

      while (!dia.isAfter(fim)) {
        diasMenstruacao.add(dia);
        dia = dia.add(const Duration(days: 1));
      }
    });
  }

  void mostrarMensagem(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void mudarMes(int quantidade) {
    setState(() {
      mesAtual = DateTime(
        mesAtual.year,
        mesAtual.month + quantidade,
      );
    });
  }

  void alternarSintoma(String sintoma) {
    setState(() {
      if (sintomasSelecionados.contains(sintoma)) {
        sintomasSelecionados.remove(sintoma);
      } else {
        sintomasSelecionados.add(sintoma);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lavenderMist,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ciclo Menstrual',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: texto,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Acompanhe seu ciclo e conheça melhor seu corpo.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 22),

              construirResumo(),

              const SizedBox(height: 22),

              construirCalendario(),

              const SizedBox(height: 22),

              construirRegistro(),

              const SizedBox(height: 22),

              construirSintomas(),

              const SizedBox(height: 22),

              construirAviso(),
            ],
          ),
        ),
      ),
    );
  }

  Widget construirResumo() {
    final temHistorico = historicoCiclos.isNotEmpty;

    final diaCiclo = temHistorico
        ? DateTime.now()
        .difference(historicoCiclos.last)
        .inDays +
        1
        : 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [deepLilac, periwinkle],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SEU CICLO',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            temHistorico
                ? 'Dia $diaCiclo do ciclo'
                : 'Comece seu acompanhamento',
            style: const TextStyle(
              color: branco,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            temHistorico
                ? 'Duração média: $duracaoCiclo dias'
                : 'Registre sua menstruação para começar.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [
              Expanded(
                child: resumoData(
                  'Próxima menstruação',
                  formatarData(proximaMenstruacao),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: resumoData(
                  'Ovulação estimada',
                  formatarData(ovulacaoPrevista),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget resumoData(String titulo, String data) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: branco.withOpacity(0.17),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            data,
            style: const TextStyle(
              color: branco,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget construirCalendario() {
    final primeiroDia = DateTime(
      mesAtual.year,
      mesAtual.month,
      1,
    );

    final totalDias = DateTime(
      mesAtual.year,
      mesAtual.month + 1,
      0,
    ).day;

    final deslocamento = primeiroDia.weekday % 7;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: branco,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => mudarMes(-1),
                icon: const Icon(
                  Icons.chevron_left,
                  color: deepLilac,
                ),
              ),

              Text(
                '${nomeMes(mesAtual.month)} ${mesAtual.year}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: texto,
                ),
              ),

              IconButton(
                onPressed: () => mudarMes(1),
                icon: const Icon(
                  Icons.chevron_right,
                  color: deepLilac,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: ['D', 'S', 'T', 'Q', 'Q', 'S', 'S']
                .map(
                  (dia) => Expanded(
                child: Center(
                  child: Text(
                    dia,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: deepLilac,
                    ),
                  ),
                ),
              ),
            )
                .toList(),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: deslocamento + totalDias,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 8,
              crossAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              if (index < deslocamento) {
                return const SizedBox();
              }

              final numeroDia = index - deslocamento + 1;

              final data = DateTime(
                mesAtual.year,
                mesAtual.month,
                numeroDia,
              );

              final menstruacao = diasMenstruacao.any(
                    (d) => mesmaData(d, data),
              );

              final ovulacao = ovulacaoPrevista != null &&
                  mesmaData(data, ovulacaoPrevista!);

              final inicioFertil = ovulacaoPrevista?.subtract(
                const Duration(days: 5),
              );

              final fertil = inicioFertil != null &&
                  !data.isBefore(inicioFertil) &&
                  !data.isAfter(ovulacaoPrevista!);

              final hoje = mesmaData(data, DateTime.now());

              Color corFundo = Colors.transparent;

              if (menstruacao) {
                corFundo = rosaMenstruacao;
              } else if (ovulacao) {
                corFundo = classicLavender;
              } else if (fertil) {
                corFundo = paleLilac;
              }

              return Container(
                decoration: BoxDecoration(
                  color: corFundo,
                  shape: BoxShape.circle,
                  border: hoje
                      ? Border.all(
                    color: deepLilac,
                    width: 2,
                  )
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$numeroDia',
                  style: const TextStyle(
                    color: texto,
                    fontSize: 13,
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: [
              legenda(rosaMenstruacao, 'Menstruação'),
              legenda(paleLilac, 'Período fértil'),
              legenda(classicLavender, 'Ovulação'),
            ],
          ),
        ],
      ),
    );
  }

  Widget legenda(Color cor, String titulo) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.circle,
          ),
        ),

        const SizedBox(width: 5),

        Text(
          titulo,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget construirRegistro() {
    return construirCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Registro menstrual',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: texto,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Informe quando sua menstruação começa e termina.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 18),

          botaoRegistro(
            Icons.water_drop_outlined,
            'Início da menstruação',
            formatarData(inicioMenstruacao),
            escolherInicio,
          ),

          const SizedBox(height: 12),

          botaoRegistro(
            Icons.check_circle_outline,
            'Fim da menstruação',
            formatarData(fimMenstruacao),
            escolherFim,
          ),
        ],
      ),
    );
  }

  Widget botaoRegistro(
      IconData icone,
      String titulo,
      String data,
      VoidCallback acao,
      ) {
    return InkWell(
      onTap: acao,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: lavenderMist,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              icone,
              color: deepLilac,
              size: 25,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: texto,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    data,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 15,
              color: deepLilac,
            ),
          ],
        ),
      ),
    );
  }

  Widget construirSintomas() {
    return construirCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Como você está se sentindo?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: texto,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Selecione os sintomas que está sentindo.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sintomas.map((sintoma) {
              final selecionado =
              sintomasSelecionados.contains(sintoma);

              return FilterChip(
                label: Text(sintoma),
                selected: selecionado,
                onSelected: (valor) {
                  alternarSintoma(sintoma);
                },
                selectedColor: paleLilac,
                backgroundColor: lavenderMist,
                checkmarkColor: deepLilac,
                labelStyle: TextStyle(
                  color: selecionado ? deepLilac : texto,
                  fontSize: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 12),

          if (sintomasSelecionados.isNotEmpty)
            Text(
              '${sintomasSelecionados.length} sintoma(s) selecionado(s)',
              style: const TextStyle(
                color: deepLilac,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
        ],
      ),
    );
  }

  Widget construirAviso() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lavenderMist,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: deepLilac,
          ),

          SizedBox(width: 10),

          Expanded(
            child: Text(
              'As previsões são estimativas e podem variar '
                  'de um ciclo para outro. Não utilize o calendário '
                  'como método contraceptivo.',
              style: TextStyle(
                fontSize: 12,
                color: texto,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget construirCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: branco,
        borderRadius: BorderRadius.circular(22),
      ),
      child: child,
    );
  }
}
