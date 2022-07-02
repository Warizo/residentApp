import 'package:resident_app/route/routing_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String fullName = "";
  int countOutstandings = 0;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  Future<void> getProfile() async {
    final preff = await SharedPreferences.getInstance();
    String surname = preff.getString("surname")!;
    String firstName = preff.getString("firstname")!;
    int prefBill = preff.getInt("outstandingsCount")!;
    final String name = "${surname} ${firstName}";
    countOutstandings = prefBill;
    if (name.length > 20) {
      fullName = surname;
    } else {
      fullName = name;
    }
    setState(() {});
  }

  Future _signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.setBool("isLoggedIn", false);
    setState(() {});
  }

  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.deepPurple,
        child: ListView(
          children: [
            buildDrawerHeader(
              image: 'assets/images/avatar.png',
              name: "$fullName",
              email: 'Resident',
              onClicked: () => Navigator.pushNamed(context, ProfileScreenRoute),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            buildMenuItem(
              text: "Dashboard",
              icon: Icons.dashboard,
              onClicked: () => Navigator.pushNamed(
                context,
                DashboardScreenRoute,
              ),
            ),
            buildMenuItem(
              text: "My Profile",
              icon: Icons.person,
              onClicked: () => Navigator.pushNamed(context, ProfileScreenRoute),
            ),
            buildMenuItem(
              text: "Token",
              icon: Icons.key,
              onClicked: () => Navigator.pushNamed(context, TokenScreenRoute),
            ),
            buildMenuItem(
              text: "My Outstandings",
              icon: Icons.wallet,
              onClicked: () => Navigator.pushNamed(
                context,
                OutStandingPaymentScreenRoute,
              ),
              badgeValue: countOutstandings,
            ),
            buildMenuItem(
              text: "Payment History",
              icon: Icons.credit_card,
              onClicked: () => Navigator.pushNamed(
                context,
                PaymentHistoryScreenRoute,
              ),
            ),
            buildMenuItem(
              text: "Vendors",
              icon: Icons.group,
              onClicked: () => Navigator.pushNamed(context, VendorScreenRoute),
            ),
            const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            buildMenuItem(
              text: "Complaint",
              icon: Icons.info_outline,
              onClicked: () =>
                  Navigator.pushNamed(context, CreateComplaintScreenRoute),
            ),
            /***
            buildMenuItem(
              text: "Notifications",
              icon: Icons.notifications_active,
              onClicked: () => Navigator.pushNamed(
                context,
                NotificationScreenRoute,
              ),
              badgeValue: 12,
            ),
            ***/
            const Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            buildMenuItem(
                text: "Sign Out",
                icon: Icons.logout_outlined,
                onClicked: () {
                  _signOut;
                  Navigator.pushReplacementNamed(
                    context,
                    LoginScreenRoute,
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget buildDrawerHeader({
    required String image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(
            const EdgeInsets.symmetric(vertical: 20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(image),
              ),
              const SizedBox(width: 10),

              // User name and email
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),

              // email
              Text(
                email,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.nunitoSans(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
    int badgeValue = 0,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: GoogleFonts.nunitoSans(color: color, fontSize: 20),
      ),
      hoverColor: hoverColor,
      trailing: badgeValue != 0
          ? Badge(
              padding: const EdgeInsets.all(8.0),
              animationDuration: const Duration(milliseconds: 300),
              animationType: BadgeAnimationType.slide,
              badgeContent: Text(
                badgeValue.toString(),
                style: const TextStyle(color: Colors.white),
              ),
            )
          : const Text(""),
      onTap: onClicked,
    );
  }
}
