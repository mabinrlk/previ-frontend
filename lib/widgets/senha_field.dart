
import 'package:flutter/material.dart';

class SenhaField extends StatefulWidget {
  final TextEditingController controller;

  const SenhaField({
    super.key,
    required this.controller,
  });

  @override
  State<SenhaField> createState() => _SenhaFieldState();
}

class _SenhaFieldState extends State<SenhaField> {
  // Controla a visibilidade da senha
  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,

      // Características de um campo de senha
      obscureText: !_senhaVisivel,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.newPassword],
      enableSuggestions: false,
      autocorrect: false,

      decoration: InputDecoration(
        labelText: 'Senha',
        hintText: 'Digite sua senha',
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        hintStyle: const TextStyle(
          color: Color(0xFF55515A),
          fontSize: 15,
        ),

        prefixIcon: const Icon(
          Icons.lock_outline,
          color: Color(0xFF9575CD),
          size: 20,
        ),

        // Botão para mostrar ou ocultar a senha
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _senhaVisivel = !_senhaVisivel;
            });
          },
          icon: Icon(
            _senhaVisivel
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: const Color(0xFF9575CD),
          ),
        ),

        filled: true,
        fillColor: const Color(0xFFFAF5FB),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Color(0xFFD1C4E9),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Color(0xFF9575CD),
            width: 1.2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.2,
          ),
        ),
      ),

      // Validação da senha
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Informe sua senha.';
        }

        if (value.length < 8) {
          return 'A senha deve ter pelo menos 8 caracteres.';
        }

        return null;
      },
    );
  }
}
