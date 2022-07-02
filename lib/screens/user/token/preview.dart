import 'package:resident_app/route/routing_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TokenPreviewScreen extends StatelessWidget {
  const TokenPreviewScreen({Key? key}) : super(key: key);

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
          'Token Preview',
          style: GoogleFonts.nunitoSans(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              icon: const Icon(Icons.notifications_active, size: 25),
              color: Colors.white,
              onPressed: () =>
                  Navigator.pushNamed(context, NotificationScreenRoute),
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            buildTileItem(leading: 'Token ID:', title: '#MGD28639'),
            buildTileItem(leading: 'Name:', title: 'Jimoh Wareez Oluwaseun'),
            buildTileItem(leading: 'Phone:', title: '08169961829'),
            buildTileItem(
              leading: 'Email:',
              title: 'j.oluwaseun@highvertical.com.ng',
            ),
            buildTileItem(leading: 'Purpose:', title: 'Official'),
            buildTileItem(leading: 'Number of Visitor:', title: '1'),
            buildTileItem(leading: 'Status:', title: 'Active'),
            buildTileItem(leading: 'Generated:', title: '29th May, 2022'),
          ],
        ),
      ),
    );
  }

  Widget buildTileItem({required String leading, required String title}) {
    return Card(
      child: ListTile(
        leading: Text(leading),
        title: Text(
          title,
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
