
class ConsultaModel {
  final int? id;
  final String especialidade;
  final String profissional;
  final DateTime data;
  final String hora;
  final String local;
  final String status;

  ConsultaModel({
    this.id,
    required this.especialidade,
    required this.profissional,
    required this.data,
    required this.hora,
    required this.local,
    required this.status,
  });

  factory ConsultaModel.fromJson(Map<String, dynamic> json) {
    return ConsultaModel(
      id: json['id'],
      especialidade: json['especialidade'] ?? '',
      profissional: json['profissional'] ?? '',
      data: DateTime.parse(json['data']),
      hora: json['hora'] ?? '',
      local: json['local'] ?? '',
      status: json['status'] ?? 'Agendada',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'especialidade': especialidade,
      'profissional': profissional,
      'data': data.toIso8601String(),
      'hora': hora,
      'local': local,
      'status': status,
    };
  }
}
