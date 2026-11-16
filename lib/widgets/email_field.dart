import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,

      decoration: const InputDecoration(
        labelText: 'E-mail',
        hintText: 'Digite seu e-mail',
        floatingLabelBehavior: FloatingLabelBehavior.auto,

        hintStyle: TextStyle(
          color: Color(0xFF55515A),
          fontSize: 15,
        ),

        prefixIcon: Icon(
          Icons.email_outlined,
          color: Color(0xFF9575CD),
          size: 20,
        ),

        filled: true,
        fillColor: Color(0xFFFAF5FB),

        contentPadding: EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          borderSide: BorderSide(
            color: Color(0xFFD1C4E9),
            width: 1,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          borderSide: BorderSide(
            color: Color(0xFF9575CD),
            width: 1.2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(17)),
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 1.2,
          ),
        ),
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Informe seu e-mail.';
        }

        if (!RegExp(
          r'^[^@\s]+@[^@\s]+\.[^@\s]{3,}$',
        ).hasMatch(value.trim())) {
          return 'Informe um e-mail válido.';
        }

        return null;
      },
    );
  }
}

