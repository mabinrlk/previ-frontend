import 'package:flutter/material.dart';

class ConsultaCard extends StatelessWidget {
  final String especialidade;
  final String profissional;
  final String data;
  final String hora;
  final String local;
  final String status;
  final VoidCallback? onTap;

  const ConsultaCard({
    super.key,
    required this.especialidade,
    required this.profissional,
    required this.data,
    required this.hora,
    required this.local,
    required this.status,
    this.onTap,
  });

  Color _corStatus() {
    switch (status.toUpperCase()) {
      case 'AGENDADA':
        return const Color(0xFF2E7D32);
      case 'CONCLUIDA':
        return const Color(0xFF1565C0);
      case 'CANCELADA':
        return const Color(0xFFC62828);
      case 'REAGENDADA':
        return const Color(0xFFEF6C00);
      default:
        return const Color(0xFF757575);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3E5F5),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.medical_services_outlined,
                    color: Color(0xFF7E57C2),
                    size: 28,
                  ),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      especialidade,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4A148C),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: _corStatus().withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: _corStatus(),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              _informacao(
                Icons.person_outline,
                profissional,
              ),

              const SizedBox(height: 8),

              _informacao(
                Icons.calendar_today_outlined,
                data,
              ),

              const SizedBox(height: 8),

              _informacao(
                Icons.access_time,
                hora,
              ),

              const SizedBox(height: 8),

              _informacao(
                Icons.location_on_outlined,
                local,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _informacao(IconData icone, String texto) {
    return Row(
      children: [
        Icon(
          icone,
          color: const Color(0xFF9575CD),
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            texto,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF616161),
            ),
          ),
        ),
      ],
    );
  }
}