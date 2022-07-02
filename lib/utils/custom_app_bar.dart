import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget? customAppBar({
  required final String title,
  final List<Widget>? actionsWidget,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.deepPurple,
    elevation: 1.0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(30),
        bottomRight: Radius.circular(30),
      ),
    ),
    title: Text(
      title,
      style: GoogleFonts.nunitoSans(
        fontSize: 22,
        color: Colors.white,
      ),
    ),
    actions: actionsWidget,
  );
}
