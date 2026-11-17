
class InformacaoSaudeModel {
  final int? id;
  final String tipo;
  final String descricao;
  final DateTime? dataRegistro;

  InformacaoSaudeModel({
    this.id,
    required this.tipo,
    required this.descricao,
    this.dataRegistro,
  });

  factory InformacaoSaudeModel.fromJson(Map<String, dynamic> json) {
    return InformacaoSaudeModel(
      id: json['id'],
      tipo: json['tipo'] ?? '',
      descricao: json['descricao'] ?? '',
      dataRegistro: json['dataRegistro'] != null
          ? DateTime.tryParse(json['dataRegistro'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'descricao': descricao,
      'dataRegistro': dataRegistro?.toIso8601String(),
    };
  }
}
