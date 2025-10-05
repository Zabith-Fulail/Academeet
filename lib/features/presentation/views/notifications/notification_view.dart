import 'package:academeet/features/presentation/views/notifications/widget/notification_card.dart';
import 'package:flutter/material.dart';

import '../../../../utils/navigation_routes.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NotificationCard(
              onTap: () =>
                  Navigator.pushNamed(context, Routes.kChangeAppointmentView),
              title: 'New Appointment Booked',
              description:
                  'You have a new appointment scheduled for tomorrow at 3 PM.',
              time: '2 hours ago',
            ),
          ],
        ),
      ),
    );
  }
}
