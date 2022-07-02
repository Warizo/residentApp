
import 'package:flutter/material.dart';

class AppTestingScreen extends StatefulWidget {
  const AppTestingScreen({Key? key}) : super(key: key);

  @override
  State<AppTestingScreen> createState() => _AppTestingScreenState();
}

class _AppTestingScreenState extends State<AppTestingScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter + Flutterwave'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Form(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(10.0)),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Full Name"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Please fill in Your Name",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Phone Number"),
                  validator: (value) => value!.isNotEmpty
                      ? null
                      : "Please fill in Your Phone number",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  validator: (value) =>
                      value!.isNotEmpty ? null : "Please fill in Your Email",
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: const InputDecoration(labelText: "Amount"),
                  validator: (value) => value!.isNotEmpty
                      ? null
                      : "Please fill in the Amount you are Paying",
                ),
              ),
              ElevatedButton(
                child: const Text('Pay with Flutterwave'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

}
