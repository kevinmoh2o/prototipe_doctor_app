import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class QuickActionsWidget extends StatelessWidget {
  const QuickActionsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final actions = AppConstants.quickActions;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: actions.map((action) {
            final label = action['label'] ?? 'Acción';
            final iconString = action['icon'] ?? 'help';

            // Convertimos el string a IconData con una función auxiliar (opcional)
            final iconData = _getIconData(iconString);

            return _buildActionButton(
              context,
              iconData,
              label,
              () {
                // Navegar o ejecutar acción
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: Colors.blueAccent.withOpacity(0.2),
              child: Icon(icon, color: Colors.blueAccent, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  // Ejemplo de método para mapear strings a IconData
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'assignment_ind':
        return Icons.assignment_ind;
      case 'date_range':
        return Icons.date_range;
      case 'receipt_long':
        return Icons.receipt_long;
      case 'paid':
        return Icons.paid;
      default:
        return Icons.help_outline;
    }
  }
}
