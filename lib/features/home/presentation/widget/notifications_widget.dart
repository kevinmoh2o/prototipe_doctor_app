import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificaciones = AppConstants.notifications;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notificaciones",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            // Construimos la lista de notificaciones
            ...notificaciones.map((noti) => ListTile(
                  leading: const Icon(Icons.notifications_active),
                  title: Text(noti),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Acción al pulsar la notificación
                  },
                )),
          ],
        ),
      ),
    );
  }
}
