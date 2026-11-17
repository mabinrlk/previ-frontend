
class CicloModel {
  final int? id;
  final DateTime dataInicio;
  final DateTime? dataFim;
  final String fluxo;
  final List<String> sintomas;
  final String? observacoes;

  CicloModel({
    this.id,
    required this.dataInicio,
    this.dataFim,
    this.fluxo = 'Não informado',
    this.sintomas = const [],
    this.observacoes,
  });

  // Verifica se a menstruação ainda está em andamento
  bool get emAndamento => dataFim == null;

  // Calcula a duração da menstruação
  int get duracaoMenstruacao {
    if (dataFim == null) {
      return DateTime.now().difference(dataInicio).inDays + 1;
    }

    return dataFim!.difference(dataInicio).inDays + 1;
  }

  // Converte o objeto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataInicio': dataInicio.toIso8601String(),
      'dataFim': dataFim?.toIso8601String(),
      'fluxo': fluxo,
      'sintomas': sintomas,
      'observacoes': observacoes,
    };
  }

  // Cria um objeto a partir de um JSON
  factory CicloModel.fromJson(Map<String, dynamic> json) {
    return CicloModel(
      id: json['id'],
      dataInicio: DateTime.parse(json['dataInicio']),
      dataFim: json['dataFim'] != null
          ? DateTime.parse(json['dataFim'])
          : null,
      fluxo: json['fluxo'] ?? 'Não informado',
      sintomas: List<String>.from(json['sintomas'] ?? []),
      observacoes: json['observacoes'],
    );
  }
}
