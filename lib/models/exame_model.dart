
class ExameModel {
  final int? id;
  final String nome;
  final DateTime data;
  final String? local;
  final String status;
  final String? resultado;

  ExameModel({
    this.id,
    required this.nome,
    required this.data,
    this.local,
    required this.status,
    this.resultado,
  });

  factory ExameModel.fromJson(Map<String, dynamic> json) {
    return ExameModel(
      id: json['id'],
      nome: json['nome'] ?? '',
      data: DateTime.parse(json['data']),
      local: json['local'],
      status: json['status'] ?? 'Pendente',
      resultado: json['resultado'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'data': data.toIso8601String(),
      'local': local,
      'status': status,
      'resultado': resultado,
    };
  }
}
