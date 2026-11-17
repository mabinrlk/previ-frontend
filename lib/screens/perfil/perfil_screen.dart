
import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  final String nomeUsuario;

  const PerfilScreen({
    super.key,
    this.nomeUsuario = 'Usuário Previ+',
  });

  static const Color roxo = Color(0xFF7E57C2);
  static const Color lilas = Color(0xFF9575CD);
  static const Color lilasClaro = Color(0xFFF3E5F5);

  void _mostrarMensagem(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        backgroundColor: roxo,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _construirOpcao({
    required BuildContext context,
    required IconData icone,
    required String titulo,
    required String subtitulo,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 5,
      ),
      leading: Container(
        width: 43,
        height: 43,
        decoration: BoxDecoration(
          color: lilasClaro,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icone,
          color: roxo,
          size: 22,
        ),
      ),
      title: Text(
        titulo,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
      subtitle: Text(
        subtitulo,
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            color: roxo,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Cartão de identificação
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: lilasClaro,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.person,
                      size: 48,
                      color: roxo,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    nomeUsuario,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4A148C),
                    ),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    'Usuário Previ+',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 16),

                  OutlinedButton.icon(
                    onPressed: () {
                      _mostrarMensagem(
                        context,
                        'A edição do perfil será disponibilizada em breve.',
                      );
                    },
                    icon: const Icon(Icons.edit_outlined, size: 17),
                    label: const Text('Editar perfil'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: roxo,
                      side: const BorderSide(color: roxo),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Dados pessoais
            const Text(
              'Minha conta',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _construirOpcao(
                    context: context,
                    icone: Icons.person_outline,
                    titulo: 'Dados pessoais',
                    subtitulo: 'Consulte suas informações pessoais',
                    onTap: () => _mostrarMensagem(
                      context,
                      'Dados pessoais: funcionalidade em desenvolvimento.',
                    ),
                  ),

                  const Divider(height: 1, indent: 70),

                  _construirOpcao(
                    context: context,
                    icone: Icons.lock_outline,
                    titulo: 'Segurança e senha',
                    subtitulo: 'Gerencie sua senha e acesso',
                    onTap: () => _mostrarMensagem(
                      context,
                      'Segurança e senha: funcionalidade em desenvolvimento.',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Preferências
            const Text(
              'Preferências',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A148C),
              ),
            ),

            const SizedBox(height: 10),

            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  _construirOpcao(
                    context: context,
                    icone: Icons.notifications_none,
                    titulo: 'Notificações',
                    subtitulo: 'Gerencie seus lembretes e avisos',
                    onTap: () => _mostrarMensagem(
                      context,
                      'Notificações: funcionalidade em desenvolvimento.',
                    ),
                  ),

                  const Divider(height: 1, indent: 70),

                  _construirOpcao(
                    context: context,
                    icone: Icons.help_outline,
                    titulo: 'Ajuda e suporte',
                    subtitulo: 'Tire suas dúvidas sobre o Previ+',
                    onTap: () => _mostrarMensagem(
                      context,
                      'Ajuda e suporte: funcionalidade em desenvolvimento.',
                    ),
                  ),

                  const Divider(height: 1, indent: 70),

                  _construirOpcao(
                    context: context,
                    icone: Icons.info_outline,
                    titulo: 'Sobre o Previ+',
                    subtitulo: 'Conheça mais sobre nosso aplicativo',
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'Previ+',
                        applicationVersion: '1.0.0',
                        applicationLegalese:
                        'Aplicativo de prevenção e acompanhamento da saúde feminina.',
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Sair da conta
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {
                  _mostrarMensagem(
                    context,
                    'A função de sair da conta será conectada ao sistema de autenticação.',
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Sair da conta'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  side: const BorderSide(color: Colors.redAccent),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Previ+ • Sua saúde em primeiro lugar',
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
