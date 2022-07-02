import 'package:resident_app/models/token.dart';
import 'package:resident_app/route/routing_constant.dart';
import 'package:resident_app/service/token.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TokenScreen extends StatelessWidget {
  String title;
  TokenScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(
        title: title,
        actionsWidget: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: IconButton(
              icon: const Icon(Icons.add_box, size: 25),
              color: Colors.white,
              onPressed: () => Navigator.pushNamed(
                context,
                CreateTokenScreenRoute,
              ),
            ),
          ),
        ],
      ),
      body: ListTileTheme(
        contentPadding: const EdgeInsets.all(15),
        iconColor: Colors.green,
        textColor: Colors.black54,
        tileColor: Colors.white70,
        style: ListTileStyle.list,
        dense: true,
        child: Container(
          margin: const EdgeInsets.only(top: 30),
          child: FutureBuilder<List<Token>>(
            future: fetchTokens(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("An error occured, please try again later!"),
                );
              } else if (snapshot.hasData) {
                return snapshot.data?.isEmpty == true
                    ? const Center(child: Text("No token found!"))
                    : TokenList(tokens: snapshot.data!);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

class TokenList extends StatelessWidget {
  const TokenList({super.key, required this.tokens});

  final List<Token> tokens;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tokens.length,
      itemBuilder: (_, index) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, TokenDetailScreenRoute,
                arguments: tokens[index]);
          },
          leading: const Image(image: AssetImage('assets/images/visitor.png')),
          title: Text("${tokens[index].visitor}"),
          subtitle: Row(
            children: [
              Text("Token: ${tokens[index].tokenID}"),
            ],
          ),
          trailing: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: (tokens[index].status == 'Unused')
                  ? Colors.green
                  : Colors.red,
            ),
            child: Text(
              "${tokens[index].status}",
              style: GoogleFonts.nunitoSans(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
