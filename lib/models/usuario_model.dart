
class UsuarioModel {
  final int? id;
  final String nome;
  final String email;
  final String? telefone;
  final DateTime? dataNascimento;

  UsuarioModel({
    this.id,
    required this.nome,
    required this.email,
    this.telefone,
    this.dataNascimento,
  });

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      id: json['id'],
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      telefone: json['telefone'],
      dataNascimento: json['dataNascimento'] != null
          ? DateTime.tryParse(json['dataNascimento'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'telefone': telefone,
      'dataNascimento': dataNascimento?.toIso8601String(),
    };
  }
}
