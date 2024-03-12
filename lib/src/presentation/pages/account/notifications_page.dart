import 'package:flutter/material.dart';

// TODO: Implement NotificationsPage

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView(
        children: [
          _buildNotificationItem(
            title: 'New message from John',
            subtitle: 'Hey, are you free to chat later?',
            time: '10:30 AM',
            isRead: false,
          ),
          _buildNotificationItem(
            title: 'New order received',
            subtitle: 'Order #12345 has been placed',
            time: '9:45 AM',
            isRead: true,
          ),
          _buildNotificationItem(
            title: 'New message from Sarah',
            subtitle: 'Can you send me the report?',
            time: 'Yesterday',
            isRead: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required bool isRead,
  }) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.notifications),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
      trailing: Text(
        time,
        style: TextStyle(
          fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
        ),
      ),
    );
  }
}
