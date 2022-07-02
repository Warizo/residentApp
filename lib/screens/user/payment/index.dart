import 'package:date_time_picker/date_time_picker.dart';
import 'package:resident_app/models/payment.dart';
import 'package:resident_app/service/payment.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:resident_app/utils/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentHistoryScreen extends StatefulWidget {
  String title;
  PaymentHistoryScreen({super.key, required this.title});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();

  dynamic allPayments;

  @override
  void initState() {
    super.initState();
    allPayments = fetchPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(title: widget.title),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'From',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: DateTimePicker(
                      type: DateTimePickerType.date,
                      dateMask: 'd MMM, yyyy',
                      initialValue: DateTime.now().toString(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      dateLabelText: 'To',
                      onChanged: (val) => print(val),
                      validator: (val) {
                        print(val);
                        return null;
                      },
                      onSaved: (val) => print(val),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListTileTheme(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              iconColor: Colors.green,
              textColor: Colors.black54,
              tileColor: Colors.white70,
              style: ListTileStyle.list,
              dense: true,
              child: FutureBuilder<List<Payment>>(
                  future: allPayments,
                  //future: fetchPayments(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text("An error occured, please try again!"),
                      );
                    } else if (snapshot.hasData) {
                      return snapshot.data?.isEmpty == true
                          ? const Center(
                              child: Text("No payment record found"),
                            )
                          : PaymentList(payments: snapshot.data!);
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentList extends StatelessWidget {
  const PaymentList({super.key, required this.payments});

  final List<Payment> payments;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: payments.length,
      itemBuilder: (BuildContext context, index) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListTile(
          title: Text(
            "${payments[index].dueType}",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black54,
            ),
          ),
          subtitle: Text(
            "Transaction Date: ${myDateFormat(payments[index].payDate!.date!)}",
            style: GoogleFonts.nunitoSans(
              color: Colors.black38,
            ),
          ),
          trailing: Text(
            "N${payments[index].payAmount}",
            style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
