import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class DaySummaryWidget extends StatelessWidget {
  const DaySummaryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtenemos la data de AppConstants
    final summaryData = AppConstants.daySummaryData;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Resumen del día",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: summaryData.map((item) {
                return _buildInfoItem(
                  title: item['title'] ?? '',
                  count: item['count'] ?? '0',
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required String title,
    required String count,
  }) {
    return Column(
      children: [
        // Ícono de ejemplo
        Icon(
          title.contains('Cita') ? Icons.calendar_today : Icons.person,
          size: 30,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
