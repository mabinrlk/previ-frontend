import 'package:flutter/material.dart';
import 'package:previ/screens/auth/register_screen.dart';
import 'package:previ/screens/auth/forgot_password_screen.dart';
import 'package:previ/widgets/primary_button.dart';
import 'package:previ/widgets/email_field.dart';
import 'package:previ/widgets/senha_field.dart';
import 'package:previ/screens/home/home_screen.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  // Paleta de cores do Previ+
  static const Color deepLilac = Color(0xFF7E57C2);
  static const Color periwinkle = Color(0xFF9575CD);
  static const Color classicLavender = Color(0xFFB39DDB);
  static const Color paleLilac = Color(0xFFD1C4E9);
  static const Color lavenderMist = Color(0xFFF3E5F5);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Previ+',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: deepLilac,
        ),
        useMaterial3: true,
      ),
      home: const TelaLogin(),
    );
  }
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  // Chave para controlar e validar o formulário
  final _formKey = GlobalKey<FormState>();

  // Controladores dos campos
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  // Controla se a senha está visível
  bool _senhaVisivel = false;

  @override
  void dispose() {
    // Libera os controladores quando a tela for fechada
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  // Realiza o login
  void _fazerLogin() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String senha = _senhaController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login realizado com sucesso!'),
          backgroundColor: MeuApp.deepLilac,
        ),
      );

      // Futuramente, os dados serão enviados para o backend.
      debugPrint('E-mail: $email');

      // Redireciona para a página inicial.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  // Decoração padrão dos campos
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
        color: MeuApp.periwinkle,
      ),

      suffixIcon: sufixo,

      filled: true,
      fillColor: MeuApp.lavenderMist.withOpacity(0.45),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 20,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: MeuApp.paleLilac,
        ),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: MeuApp.paleLilac,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: MeuApp.deepLilac,
          width: 2,
        ),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),

          child: Form(
            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 50),

                // Identidade do aplicativo
                const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite_outlined,
                        size: 75,
                        color: MeuApp.deepLilac,
                      ),

                      SizedBox(height: 8),

                      Text(
                        'Previ+',
                        style: TextStyle(
                          color: MeuApp.deepLilac,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 45),

                // Título
                const Text(
                  'Bem-vinda!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: MeuApp.deepLilac,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Entre na sua conta e continue se cuidando.',
                  style: TextStyle(
                    fontSize: 16,
                    color: MeuApp.periwinkle,
                  ),
                ),

                  // campo email
                const SizedBox(height: 25),
                EmailField(
                  controller: _emailController,
                ),

                  // campo senha
                const SizedBox(height: 19),
                SenhaField(controller: _senhaController),

                 // campo Recuperação de senha
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,

                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RecoverScreen(),
                        ),
                      );
                    },

                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blue,
                    ),

                    child: const Text(
                      'Esqueci minha senha',
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                PrimaryButton(
                  texto: 'Entrar',
                  onPressed: _fazerLogin,
                ),

                const SizedBox(height: 5),
                // Link para cadastro
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const cadastro(),
                        ),
                      );
                    },

                    child: const Text.rich(
                      TextSpan(
                        text: 'Ainda não possui uma conta? ',
                        style: TextStyle(
                          color: MeuApp.periwinkle,
                          fontSize: 14,
                        ),

                        children: [
                          TextSpan(
                            text: 'Cadastre-se',
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