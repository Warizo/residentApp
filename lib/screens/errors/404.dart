import 'package:resident_app/route/routing_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageNotFoundScreen extends StatelessWidget {
  final String? name;

  const PageNotFoundScreen({Key? key, required this.name}) : super(key: key);

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
          'Vistor Token',
          style: GoogleFonts.nunitoSans(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              icon: const Icon(Icons.home, size: 25),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, DashboardScreenRoute);
              },
            ),
          ),
        ],
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            '404',
            style: GoogleFonts.nunitoSans(
              fontSize: 45,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$name Page Not Found',
            style: GoogleFonts.nunitoSans(
              fontSize: 35,
              color: Colors.black45,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )),
    );
  }
}
