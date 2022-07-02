import 'dart:convert';
import 'dart:async';

import 'package:cool_alert/cool_alert.dart';
import 'package:resident_app/const/api_constants.dart';
import 'package:resident_app/models/outstanding.dart';
import 'package:resident_app/service/outstanding.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:resident_app/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_cart/flutter_cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class OutStandingPaymentScreen extends StatefulWidget {
  String title;
  OutStandingPaymentScreen({super.key, required this.title});

  @override
  State<OutStandingPaymentScreen> createState() =>
      _OutStandingPaymentScreenState();
}

class _OutStandingPaymentScreenState extends State<OutStandingPaymentScreen> {
  bool isTestMode = true;
  final String flutter_pbk = "FLWPUBK_TEST-ffb743bb6c0830f1a3ebba66ecfebac4-X";
  final String txref = "FLWSECK_TESTd9a96279ab53";
  final String currency = "NGN";
  final bool isDebug = true;
  var uuid = const Uuid();

  var fullName;
  var email;
  var phone;
  var residentID;

  Future<void> getProfile() async {
    final preff = await SharedPreferences.getInstance();
    String surname = preff.getString("surname")!;
    String firstName = preff.getString("firstname")!;
    String emailVal = preff.getString("email")!;
    String phoneVal = preff.getString("phone")!;
    String resID = preff.getString("residenceID")!;
    final String name = "$surname $firstName";
    if (name.length > 20) {
      fullName = surname;
    } else {
      fullName = name;
    }
    email = emailVal;
    phone = phoneVal;
    residentID = resID;
  }

  List<dynamic> outstandingChecked = [];

  var cart = FlutterCart();

  @override
  void initState() {
    super.initState();
    cart.deleteAllCart();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(title: widget.title),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Outstanding Debt',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 32,
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Select the outstanding debt you are ready to pay for now!',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListTileTheme(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    iconColor: Colors.green,
                    textColor: Colors.black54,
                    tileColor: Colors.white70,
                    style: ListTileStyle.list,
                    dense: true,
                    child: FutureBuilder<List<Outstanding>>(
                      future: fetchOutstandings(),
                      builder: (BuildContext context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              'An error occurred, please try again later!',
                            ),
                          );
                        } else if (snapshot.hasData) {
                          dynamic outstandings = snapshot.data;
                          return snapshot.data?.isEmpty == true
                              ? const Center(
                                  child: Text(
                                    "You do not have any outstanding payment yet!",
                                  ),
                                )
                              : buildOutstandingList(
                                  outstandings: snapshot.data!);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
                Positioned(
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 20,
                    ),
                    color: Colors.white70,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Text(
                          'N${cart.getTotalAmount()}',
                          style: GoogleFonts.nunitoSans(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton.icon(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: _onPressed,
                          icon: const Icon(Icons.payments),
                          label: Text(
                            'Pay Now',
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onPressed() {
    if (cart.getCartItemCount() > 0) {
      _handlePaymentInitialization();
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: 'Please, select an outstanding to pay for.',
      );
    }
  }

  _handlePaymentInitialization() async {
    final style = FlutterwaveStyle(
      appBarText: "Confirm Payment",
      buttonColor: const Color(0xFF673AB7),
      buttonTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      appBarColor: const Color(0xFF673AB7),
      dialogCancelTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      dialogContinueTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      mainBackgroundColor: Colors.deepPurple.shade100,
      mainTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 19,
        letterSpacing: 2,
      ),
      dialogBackgroundColor: Colors.deepPurple,
      //appBarIcon: const Icon(Icons.arrow_back_ios, color: Colors.white),
      buttonText: "Pay $currency${cart.getTotalAmount()}",
      appBarTitleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
    );

    final Customer customer = Customer(
      name: fullName,
      phoneNumber: phone,
      email: email,
    );

    final Flutterwave flutterwave = Flutterwave(
      context: context,
      style: style,
      publicKey: flutter_pbk,
      currency: currency,
      txRef: uuid.v1(),
      amount: cart.getTotalAmount().toString(),
      customer: customer,
      paymentOptions: "card, payattitude",
      customization: Customization(title: "Estate Due(s) Payment"),
      isTestMode: isTestMode,
    );

    final ChargeResponse response = await flutterwave.charge();

    if (response != null) {
      if (response.status == "success") {
        postPament(outstandingChecked);
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: "${response.status}",
        );
      }
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "No Response!",
      );
    }
  }

  Future<void> showLoading(String? message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            margin: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            width: double.infinity,
            height: 50,
            child: Text("$message"),
          ),
        );
      },
    );
  }

  buildOutstandingList({outstandings}) {
    return ListView.builder(
      itemCount: outstandings.length,
      itemBuilder: (BuildContext context, index) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListTile(
          leading: Checkbox(
            activeColor: Colors.deepPurple,
            value: outstandingChecked.contains(outstandings[index].id),
            onChanged: (val) {
              dynamic selectedIndex =
                  cart.findItemIndexFromCart(outstandings[index].id);

              dynamic inputData = {
                "id": outstandings[index].id,
                "dueType": outstandings[index].dueType,
                "payAmount": outstandings[index].billAmount,
                "residentID": residentID,
                "payMode": "Card",
              };

              var encodeData = jsonEncode(inputData);

              _onSelected(val, outstandings[index].id, encodeData);

              setState(() {
                outstandings[index].isChecked = val;

                if (val == true) {
                  cart.addToCart(
                    productId: outstandings[index].id,
                    unitPrice: num.parse(outstandings[index].billAmount),
                    productName: outstandings[index].dueType,
                  );
                } else {
                  cart.deleteItemFromCart(selectedIndex);
                }
              });
            },
          ),
          title: Text(
            outstandings[index].dueType,
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
              "Due Date: ${myDateFormat(outstandings[index].billDate!.date)}"),
          trailing: Text(
            'N${outstandings[index].billAmount}',
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  Future postPament(paymentData) async {
    dynamic dataToString = '$paymentData';
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.paymentsEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(dataToString),
    );

    if (response.statusCode == 200) {
      dynamic responsne = jsonDecode(response.body);
      if (responsne[0]['status']) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: responsne[0]['message'],
        )
            .then((value) => outstandingChecked)
            .then((value) => cart.deleteAllCart());
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: responsne[0]['message'],
        )
            .then((value) => outstandingChecked)
            .then((value) => cart.deleteAllCart());
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to insert payment. API Connection Failed');
    }
  }

  void _onSelected(bool? selected, int dataID, dynamic data) {
    if (selected == true) {
      setState(() {
        outstandingChecked.add(dataID);
        outstandingChecked.add(data);
      });
    } else {
      setState(() {
        outstandingChecked.remove(dataID);
        outstandingChecked.remove(data);
      });
    }
  }
}
