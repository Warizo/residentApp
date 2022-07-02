import 'package:resident_app/models/notification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  final List<AppNotification> _notifications = [
    AppNotification(
      id: 1,
      text: 'Your account activated successfully',
      date: '20-01-2022',
    ),
    AppNotification(
      id: 2,
      text: 'You have not yet pay your due, please try and pay',
      date: '20-05-2022',
    ),
    AppNotification(
      id: 3,
      text:
          'Someone is at the gate looking for you, already passed in with the ticket',
      date: '06-06-2022',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.nunitoSans(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.green,
        textColor: Colors.black54,
        tileColor: Colors.white70,
        style: ListTileStyle.list,
        dense: true,
        child: Container(
          margin: const EdgeInsets.only(top: 39),
          child: ListView.builder(
            itemCount: _notifications.length,
            itemBuilder: (_, index) => Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: ListTile(
                leading: const Icon(Icons.notifications),
                title: Text(_notifications[index].text),
                trailing: Text(_notifications[index].date),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
