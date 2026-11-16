import 'package:flutter/material.dart';
import 'package:previ/widgets/senha_field.dart';
import 'login_screen.dart';
import 'package:previ/widgets/primary_button.dart';
import 'package:previ/widgets/email_field.dart';


class cadastro extends StatefulWidget {
  const cadastro({super.key});

  @override
  State<cadastro> createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {

  // Paleta de cores do Previ+
  static const Color deepLilac = Color(0xFF7E57C2);
  static const Color periwinkle = Color(0xFF9575CD);
  static const Color classicLavender = Color(0xFFB39DDB);
  static const Color paleLilac = Color(0xFFD1C4E9);
  static const Color lavenderMist = Color(0xFFF3E5F5);

  // Controladores dos campos
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  final List<TextEditingController> telefonesControllers = [
    TextEditingController()
  ];

  DateTime? dataNascimento;

  bool _senhaVisivel = true;

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();

    for (var controller in telefonesControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  // Adicionar telefone
  void adicionarTelefone() {
    setState(() {
      telefonesControllers.add(TextEditingController());
    });
  }

  // Remover telefone
  void removerTelefone(int index) {
    setState(() {
      telefonesControllers[index].dispose();
      telefonesControllers.removeAt(index);
    });
  }

  // Selecionar data de nascimento
  Future<void> selecionarData() async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: 'Selecione sua data de nascimento',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: deepLilac,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: deepLilac,
            ),
          ),
          child: child!,
        );
      },
    );

    if (dataSelecionada != null) {
      setState(() {
        dataNascimento = dataSelecionada;
      });
    }
  }

  // Formatar data
  String formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/'
        '${data.month.toString().padLeft(2, '0')}/'
        '${data.year}';
  }

  // Realizar cadastro
  void cadastrar() {
    if (_formKey.currentState!.validate()) {

      if (dataNascimento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Selecione sua data de nascimento.'),
          ),
        );
        return;
      }

      final telefones = telefonesControllers
          .map((controller) => controller.text.trim())
          .where((telefone) => telefone.isNotEmpty)
          .toList();

      // Dados preparados para integração com o backend
      final dadosCadastro = {
        'nome': nomeController.text.trim(),
        'email': emailController.text.trim(),
        'senha': senhaController.text,
        'dataNascimento': formatarData(dataNascimento!),
        'telefones': telefones,
      };

      debugPrint('Dados do cadastro: $dadosCadastro');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados validados com sucesso!'),
          backgroundColor: deepLilac,
        ),
      );

      // Aqui futuramente faremos a integração com o backend.
    }
  }

  // Estilo dos campos
  InputDecoration decoracaoCampo({
    required String label,
    required String hint,
    required IconData icone,
    Widget? sufixo,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(
        icone,
        color: periwinkle,
      ),
      suffixIcon: sufixo,
      filled: true,
      fillColor: lavenderMist.withOpacity(0.45),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: paleLilac),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: paleLilac),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: deepLilac,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: deepLilac,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Previ+',
          style: TextStyle(
            color: deepLilac,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Título
                const Text(
                  'Vamos começar?',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: deepLilac,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Crie sua conta no Previ+ e cuide '
                      'ainda melhor da sua saúde.',
                  style: TextStyle(
                    fontSize: 16,
                    color: periwinkle,
                  ),
                ),

                const SizedBox(height: 31),

                // Nome
                TextFormField(
                  controller: nomeController,
                  keyboardType: TextInputType.name,
                  decoration: decoracaoCampo(
                    label: 'Nome',
                    hint: 'Digite seu nome',
                    icone: Icons.person_outline,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Informe seu nome';
                    }

                    if (value.trim().length < 3) {
                      return 'O nome deve ter pelo menos 3 caracteres';
                    }

                    return null;
                  },
                ),

                  // campo email
                const SizedBox(height: 16),
                EmailField(
                  controller: emailController,
                ),

                 // campo senha
                const SizedBox(height: 16),
                SenhaField(
                    controller: senhaController
                ),

                const SizedBox(height: 16),

                // Data de nascimento
                InkWell(
                  onTap: selecionarData,
                  borderRadius: BorderRadius.circular(18),
                  child: InputDecorator(
                    decoration: decoracaoCampo(
                      label: 'Data de nascimento',
                      hint: 'DD/MM/AAAA',
                      icone: Icons.calendar_month_outlined,
                      sufixo: const Icon(
                        Icons.calendar_today_outlined,
                        color: periwinkle,
                      ),
                    ),
                    child: Text(
                      dataNascimento == null
                          ? 'DD/MM/AAAA'
                          : formatarData(dataNascimento!),
                      style: TextStyle(
                        fontSize: 14,
                        color: dataNascimento == null
                            ? Colors.grey
                            : deepLilac,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Título dos telefones
                const Row(
                  children: [
                    Icon(
                      Icons.phone_outlined,
                      color: deepLilac,
                      size: 27,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Telefones',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: deepLilac,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                const Text(
                  'Adicione um ou mais números de telefone.',
                  style: TextStyle(
                    color: periwinkle,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 15),

                // Lista dinâmica de telefones
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: lavenderMist,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Column(
                    children: [

                      ...List.generate(
                        telefonesControllers.length,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),

                            child: Row(
                              children: [

                                Expanded(
                                  child: TextFormField(
                                    controller: telefonesControllers[index],
                                    keyboardType: TextInputType.phone,
                                    maxLength: 11,
                                    decoration: decoracaoCampo(
                                      label: 'Telefone ${index + 1}',
                                      hint: 'Insira seu número',
                                      icone: Icons.phone,
                                    ).copyWith(
                                      counterText: '',
                                    ),

                                    validator: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return 'O telefone é obrigatório.';
                                      }

                                      String numero = value.replaceAll(RegExp(r'\D'), '');

                                      if (!RegExp(r'^[1-9][0-9]9[0-9]{8}$')
                                          .hasMatch(numero)) {
                                        return 'Informe um celular válido com DDD.';
                                      }

                                      return null;
                                    },
                                  ),
                                ),

                                IconButton(
                                  onPressed: () {
                                    removerTelefone(index);
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: deepLilac,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),

                      // Adicionar telefone
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: adicionarTelefone,
                          icon: const Icon(Icons.add),
                          label: const Text(
                            'Adicionar outro telefone',
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: deepLilac,
                            side: const BorderSide(
                              color: deepLilac,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  texto: 'Cadastrar',
                  onPressed: cadastrar,
                ),

                const SizedBox(height: 22),

                // Login
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaLogin(),
                        ),
                      );
                    },
                    child: const Text.rich(
                      TextSpan(
                        text: 'Já tem uma conta? ',
                        style: TextStyle(
                          color: periwinkle,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Faça login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
