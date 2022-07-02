import 'package:resident_app/models/vendor.dart';
import 'package:resident_app/service/vendor.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorScreen extends StatelessWidget {
  String title;
  VendorScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(title: title),
      body: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.green,
        textColor: Colors.black54,
        tileColor: Colors.white70,
        style: ListTileStyle.list,
        dense: true,
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: FutureBuilder<List<Vendor>>(
            future: fetchVendors(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occured, please try again later!'),
                );
              } else if (snapshot.hasData) {
                return snapshot.data?.isEmpty == true
                    ? const Center(
                        child: Text(
                          "'Sorry, no available vendor at the moment, please check back!",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : VendorList(vendors: snapshot.data!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class VendorList extends StatelessWidget {
  const VendorList({super.key, required this.vendors});

  final List<Vendor> vendors;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vendors.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListTile(
          leading: const Image(image: AssetImage('assets/images/visitor.png')),
          title: Text(
            "${vendors[index].vendorname}",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            "${vendors[index].vendorProfession}",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          trailing: ElevatedButton.icon(
            icon: const Icon(Icons.call),
            onPressed: () async {
              FlutterPhoneDirectCaller.callNumber(
                "${vendors[index].vendorTel}",
              );
            },
            label: const Text("Call"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
          ),
        ),
      ),
    );
  }
}
