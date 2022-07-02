import 'dart:convert';
import 'dart:async';

import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:resident_app/utils/date_format.dart';
import 'package:http/http.dart' as http;

import 'package:resident_app/const/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  String title;
  ProfileScreen({super.key, required this.title});

  Future getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String fullId = prefs.getString("residenceID")!;
    final String residentID = fullId.substring(1);
    Map<String, String> queryParams = {
      "residentID": residentID,
    };
    final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint)
        .replace(queryParameters: queryParams);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      var profile = jsonDecode(response.body);
      return profile;
    } else {
      throw Exception("Error: Connection to Profile Api");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(title: title),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: getProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("An error occured, Please try again!"),
            );
          } else if (snapshot.hasData) {
            return ResidentProfile(profile: snapshot.data);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget buildBioTile({required IconData icon, required String title}) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
      ),
      title: Text(
        title,
        style: GoogleFonts.nunitoSans(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget ResidentProfile({required profile}) {
    return Stack(
      children: [
        // Top background
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: 380,
            margin: const EdgeInsets.only(top: 30),
            decoration: const BoxDecoration(
              color: Colors.purple,
            ),
            foregroundDecoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.6),
            ),
          ),
        ),

        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: 400,
            decoration: const BoxDecoration(
              color: Colors.deepPurple,
              image: DecorationImage(
                image: AssetImage('assets/images/profile_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            foregroundDecoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.6),
            ),
          ),
        ),

        ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            const SizedBox(height: 90),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: CircleAvatar(
                radius: 78,
                backgroundImage: AssetImage("assets/images/avatar.png"),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "${profile[0]['profile']['Surname'] ?? ''} ${profile[0]['profile']['FirstName'] ?? 'Please update profile'}",
              style: GoogleFonts.nunitoSans(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5.0),
            Text(
              'Resident',
              style: GoogleFonts.nunito(
                fontSize: 20,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Card(
              color: Colors.white,
              elevation: 0.0,
              margin: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 8.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${profile[0]['profile']['ResidenceID'] ?? 'Please update profile'}",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Residence ID'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "${myDateFormat(profile[0]['profile']['DOB']['date']) ?? 'Please update profile'}",
                            style: GoogleFonts.nunitoSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text('Date of Birth'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Bio',
                style: GoogleFonts.nunitoSans(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  buildBioTile(
                    icon: Icons.account_circle,
                    title:
                        "${profile[0]['profile']['Surname'] ?? ''} ${profile[0]['profile']['FirstName'] ?? 'Please update profile'}",
                  ),
                  buildBioTile(
                    icon: Icons.phone,
                    title:
                        "${profile[0]['profile']['PhoneNumber'] ?? 'Please update profile'}",
                  ),
                  buildBioTile(
                    icon: Icons.mail,
                    title:
                        "${profile[0]['profile']['Email'] ?? 'Please update profile'}",
                  ),
                  buildBioTile(
                    icon: Icons.calendar_month,
                    title:
                        "${myDateFormat(profile[0]['profile']['DOB']['date']) ?? 'Please update profile'}",
                  ),
                  buildBioTile(
                    icon: Icons.location_on,
                    title:
                        "${profile[0]['profile']['EstateAddress'] ?? 'Please update profile'}",
                  ),
                  buildBioTile(
                    icon: Icons.not_listed_location_sharp,
                    title:
                        "Apartment: ${profile[0]['profile']['ApartmentInfo'] ?? 'Please update profile'}",
                  ),
                  buildBioTile(
                    icon: Icons.location_city,
                    title:
                        "Zone: ${profile[0]['profile']['Zone'] ?? 'Please update profile'}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
