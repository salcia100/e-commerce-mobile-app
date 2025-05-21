import 'package:flutter/material.dart';
import 'package:inscri_ecommerce/api/notifications_api.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> notifications = [];
  final NotificationsApi notificationsApi = NotificationsApi();

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  void loadNotifications() async {
    try {
      List<Map<String, dynamic>> data =
          await notificationsApi.fetchNotifications();
      setState(() {
        notifications = data;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context)
              .appBarTheme
              .backgroundColor, 
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context)
                    .iconTheme
                    .color), 
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Notifications',
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.color)), 
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notif = notifications[index];
            return ListTile(
              title: Text(notif['title']?? 'No title'),
              subtitle: Text(notif['message']),
              trailing: notif['is_read'] == 0
                  ? Icon(Icons.circle, color: Colors.blue, size: 10)
                  : null,
            );
          },
        ));
  }
}
