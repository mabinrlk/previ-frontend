import 'package:flutter/material.dart';
import 'package:previ/widgets/primary_button.dart';
import 'package:previ/widgets/email_field.dart';


class RecoverScreen extends StatefulWidget {
  const RecoverScreen({super.key});

  @override
  State<RecoverScreen> createState() => _RecoverScreenState();
}

class _RecoverScreenState extends State<RecoverScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // Paleta de cores Previ+
  static const Color deepLilac = Color(0xFF7E57C2);
  static const Color periwinkle = Color(0xFF9575CD);
  static const Color classicLavender = Color(0xFFB39DDB);
  static const Color paleLilac = Color(0xFFD1C4E9);
  static const Color lavenderMist = Color(0xFFF3E5F5);

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _enviarLink() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Solicitação enviada para $email'),
          backgroundColor: deepLilac,
        ),
      );

      // Futuramente: integração com o backend
      print('E-mail para recuperação: $email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text('Previ+'),

        titleTextStyle: const TextStyle(
          color: deepLilac,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: deepLilac,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),

            child: Form(
              key: _formKey,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // Ícone principal
                  const Icon(
                    Icons.lock_reset_rounded,
                    size: 90,
                    color: classicLavender,
                  ),

                  const SizedBox(height: 25),

                  // Título
                  const Text(
                    'Recuperar senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: deepLilac,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Descrição
                  const Text(
                    'Não se preocupe! Informe o e-mail '
                        'cadastrado para receber as instruções '
                        'de recuperação da sua senha.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  EmailField(
                    controller: _emailController,
                  ),

                  const SizedBox(height: 25),

                  // Botão de envio
                  const SizedBox(height: 25),
                  PrimaryButton(
                    texto: 'Enviar link',
                    onPressed: _enviarLink,
                  ),

                  const SizedBox(height: 25),

                  // Voltar para login
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      const Text(
                        'Lembrou sua senha?',
                        style: TextStyle(
                          color: deepLilac,
                        ),
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },

                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blue,
                        ),

                        child: const Text('Entrar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
