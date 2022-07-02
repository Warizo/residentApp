import 'dart:convert';

import 'package:resident_app/const/api_constants.dart';
import 'package:resident_app/route/routing_constant.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:resident_app/utils/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  String title;
  DashboardScreen({super.key, required this.title});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future getStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String fullId = prefs.getString("residenceID")!;
    final String residentID = fullId.substring(1);
    Map<String, String> queryParams = {
      "residentID": residentID,
    };

    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.statsEndpoint)
        .replace(queryParameters: queryParams);

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final stats = jsonDecode(response.body);
      final billCounter = stats[0]["bill"]["outstandings"];
      prefs.setInt("outstandingsCount", billCounter);
      return stats;
    } else {
      throw Exception("Unable to fetch payments");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      drawer: const NavigationDrawer(),
      appBar: customAppBar(title: widget.title),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: FutureBuilder(
            future: getStats(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("An error occured, please try again!"),
                );
              } else if (snapshot.hasData) {
                return statGrid(data: snapshot.data);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget buildCardItem({
    required String title,
    String text = '',
    required IconData icon,
    MaterialColor iconColor = Colors.deepPurple,
    required VoidCallback onClicked,
  }) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onClicked,
        splashColor: Colors.deepPurple,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top icon
              Icon(
                icon,
                size: 50,
                color: iconColor,
              ),

              // Count
              Text(
                text,
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Title
              Text(
                title,
                style: GoogleFonts.nunitoSans(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget statGrid({required dynamic data}) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        // Visitors
        buildCardItem(
          icon: Icons.people,
          text: "${data[0]["visitors"]}",
          title: 'My Visitors',
          iconColor: Colors.deepPurple,
          onClicked: () => Navigator.pushNamed(context, TokenScreenRoute),
        ),

        // Messages
        buildCardItem(
          icon: Icons.comment,
          text: "${data[0]["messages"]}",
          title: 'Messages',
          iconColor: Colors.teal,
          onClicked: () => Navigator.pushNamed(context, DashboardScreenRoute),
        ),

        // Outstanding
        buildCardItem(
          icon: Icons.credit_card,
          text: "N${data[0]["bill"]["bill"]}",
          title: 'My Outstandings',
          iconColor: Colors.red,
          onClicked: () =>
              Navigator.pushNamed(context, OutStandingPaymentScreenRoute),
        ),

        // Notifications
        buildCardItem(
          icon: Icons.info_outline,
          text: "${data[0]["complaints"]}",
          title: 'Complaints',
          iconColor: Colors.grey,
          onClicked: () =>
              Navigator.pushNamed(context, CreateComplaintScreenRoute),
        ),
      ],
    );
  }
}
