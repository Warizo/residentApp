import 'package:resident_app/models/token.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:resident_app/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TokenDetailScreen extends StatelessWidget {
  dynamic args;
  TokenDetailScreen({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Token;

    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(title: "Token: ${args.tokenID}"),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
          children: [
            buildTileItem(leading: 'Token ID:', title: this.args.tokenID),
            buildTileItem(leading: 'Name:', title: this.args.visitor),
            //buildTileItem(leading: 'Phone:', title: this.args.visitorsEmail),
            buildTileItem(
              leading: 'Email:',
              title: this.args.visitorsEmail,
            ),
            buildTileItem(leading: 'Reason:', title: this.args.reason),
            buildTileItem(
                leading: 'Number of Visitor:', title: '${this.args.visitorNo}'),
            buildTileItem(leading: 'Status:', title: this.args.status),
            buildTileItem(
                leading: 'Generated:',
                title: myDateFormat(this.args.generated.date)),
            buildTileItem(
                leading: 'Logged In:',
                title: myDateFormat(this.args.login.date)),
            buildTileItem(
                leading: 'Logged Out:',
                title: myDateFormat(this.args.logOut.date)),
          ],
        ),
      ),
    );
  }

  Widget buildTileItem({required String leading, required String title}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 0.9),
      child: ListTile(
        leading: Text(
          leading,
          style: GoogleFonts.nunitoSans(
            color: Colors.black45,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.nunito(
              fontWeight: FontWeight.bold,
              color: title == "Unused" ? Colors.green : Colors.black87),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
