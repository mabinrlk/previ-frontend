
import 'package:flutter/material.dart';
import 'package:previ/widgets/exame_card.dart';
import 'package:previ/widgets/consulta_card.dart';

class AgendaScreen extends StatefulWidget {
  const AgendaScreen({super.key});

  @override
  State<AgendaScreen> createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  // Lista de exames
  final List<Map<String, String>> _exames = [
    {
      'nome': 'Hemograma completo',
      'data': '20/11/2026',
      'hora': '08:30',
      'local': 'Laboratório de análises clínicas',
      'status': 'AGENDADO',
    },
    {
      'nome': 'Ultrassonografia',
      'data': '25/11/2026',
      'hora': '10:00',
      'local': 'Clínica de diagnóstico',
      'status': 'AGENDADO',
    },
  ];

  // Lista de consultas
  final List<Map<String, String>> _consultas = [
    {
      'especialidade': 'Ginecologia',
      'profissional': 'Dra. Ana',
      'data': '22/11/2026',
      'hora': '14:00',
      'local': 'Clínica de saúde',
      'status': 'AGENDADA',
    },
    {
      'especialidade': 'Clínico geral',
      'profissional': 'Dr. Carlos',
      'data': '28/11/2026',
      'hora': '09:00',
      'local': 'Unidade de saúde',
      'status': 'AGENDADA',
    },
  ];

  // Abre o formulário de cadastro
  Future<void> _mostrarFormulario({required bool exame}) async {
    final formKey = GlobalKey<FormState>();

    final nomeController = TextEditingController();
    final profissionalController = TextEditingController();
    final dataController = TextEditingController();
    final horaController = TextEditingController();
    final localController = TextEditingController();

    try {
      final resultado = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return StatefulBuilder(
            builder: (context, atualizarDialog) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  exame ? 'Adicionar exame' : 'Adicionar consulta',
                  style: const TextStyle(
                    color: Color(0xFF7E57C2),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _campo(
                          controller: nomeController,
                          label: exame ? 'Nome do exame' : 'Especialidade',
                          icone: exame
                              ? Icons.science_outlined
                              : Icons.medical_services_outlined,
                        ),

                        if (!exame) ...[
                          const SizedBox(height: 14),
                          _campo(
                            controller: profissionalController,
                            label: 'Nome do profissional',
                            icone: Icons.person_outline,
                          ),
                        ],

                        const SizedBox(height: 14),

                        // Campo de data
                        TextFormField(
                          controller: dataController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Data',
                            prefixIcon: Icon(
                              Icons.calendar_today_outlined,
                              color: Color(0xFF9575CD),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final dataEscolhida = await showDatePicker(
                              context: dialogContext,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                              locale: const Locale('pt', 'BR'),
                            );

                            if (dataEscolhida != null) {
                              atualizarDialog(() {
                                dataController.text =
                                '${dataEscolhida.day.toString().padLeft(
                                    2, '0')}/'
                                    '${dataEscolhida.month.toString().padLeft(
                                    2, '0')}/'
                                    '${dataEscolhida.year}';
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione uma data';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 14),

                        // Campo de horário
                        TextFormField(
                          controller: horaController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Horário',
                            prefixIcon: Icon(
                              Icons.access_time,
                              color: Color(0xFF9575CD),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onTap: () async {
                            final horarioEscolhido = await showTimePicker(
                              context: dialogContext,
                              initialTime: TimeOfDay.now(),
                            );

                            if (horarioEscolhido != null) {
                              atualizarDialog(() {
                                horaController.text =
                                '${horarioEscolhido.hour.toString().padLeft(
                                    2, '0')}:'
                                    '${horarioEscolhido.minute
                                    .toString()
                                    .padLeft(2, '0')}';
                              });
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Selecione um horário';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 14),

                        _campo(
                          controller: localController,
                          label: 'Local',
                          icone: Icons.location_on_outlined,
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialogContext, false);
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7E57C2),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(dialogContext, true);
                      }
                    },
                    child: const Text('Salvar'),
                  ),
                ],
              );
            },
          );
        },
      );

      // Adiciona o registro à lista
      if (resultado == true && mounted) {
        setState(() {
          if (exame) {
            _exames.add({
              'nome': nomeController.text.trim(),
              'data': dataController.text,
              'hora': horaController.text,
              'local': localController.text.trim(),
              'status': 'AGENDADO',
            });
          } else {
            _consultas.add({
              'especialidade': nomeController.text.trim(),
              'profissional': profissionalController.text.trim(),
              'data': dataController.text,
              'hora': horaController.text,
              'local': localController.text.trim(),
              'status': 'AGENDADA',
            });
          }
        });
      }
    } finally {
      // Aguarda a conclusão do frame antes de descartar os controllers.
      await WidgetsBinding.instance.endOfFrame;

      nomeController.dispose();
      profissionalController.dispose();
      dataController.dispose();
      horaController.dispose();
      localController.dispose();
    }
  }

  // Campo de texto reutilizável
  Widget _campo({
    required TextEditingController controller,
    required String label,
    required IconData icone,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          icone,
          color: const Color(0xFF9575CD),
        ),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value
            .trim()
            .isEmpty) {
          return 'Preencha este campo';
        }
        return null;
      },
    );
  }

  // Aba de exames
  Widget _construirAbaExames() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Acompanhe seus exames',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Consulte seus exames agendados e realizados.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),

        ..._exames.map(
              (exame) =>
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ExameCard(
                  nome: exame['nome']!,
                  data: exame['data']!,
                  hora: exame['hora']!,
                  local: exame['local']!,
                  status: exame['status']!,
                ),
              ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () => _mostrarFormulario(exame: true),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar exame'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E57C2),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Aba de consultas
  Widget _construirAbaConsultas() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Acompanhe suas consultas',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4A148C),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Consulte suas consultas agendadas e realizadas.',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),

        ..._consultas.map(
              (consulta) =>
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: ConsultaCard(
                  especialidade: consulta['especialidade']!,
                  profissional: consulta['profissional']!,
                  data: consulta['data']!,
                  hora: consulta['hora']!,
                  local: consulta['local']!,
                  status: consulta['status']!,
                ),
              ),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            onPressed: () => _mostrarFormulario(exame: false),
            icon: const Icon(Icons.add),
            label: const Text('Adicionar consulta'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7E57C2),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: true,
          title: const Text(
            'Minha Agenda',
            style: TextStyle(
              color: Color(0xFF7E57C2),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF7E57C2),
            indicatorWeight: 3,
            labelColor: Color(0xFF7E57C2),
            unselectedLabelColor: Colors.grey,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            tabs: [
              Tab(text: 'Exames'),
              Tab(text: 'Consultas'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _construirAbaExames(),
            _construirAbaConsultas(),
          ],
        ),
      ),
    );
  }
}