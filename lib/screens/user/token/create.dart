import 'package:resident_app/service/token.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTokenScreen extends StatefulWidget {
  String title;
  CreateTokenScreen({super.key, required this.title});

  @override
  State<CreateTokenScreen> createState() => _CreateTokenScreenState();
}

class _CreateTokenScreenState extends State<CreateTokenScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _purpose = TextEditingController();
  final TextEditingController _visitorNo = TextEditingController();

  void _validate() {
    bool validate = _formKey.currentState!.validate();
    if (validate) {
      final data = {
        "visitorName": _name.text.toString(),
        "visitorPhone": _phone.text.toString(),
        "visitorEmail": _email.text.toString(),
        "visitorNo": _visitorNo.text.toString(),
        "reason": _purpose.text.toString(),
      };

      postToken(context, data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: customAppBar(title: widget.title),
      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // visitor name textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: _name,
                        validator: ValidationBuilder()
                            .minLength(3)
                            .maxLength(50)
                            .build(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Visitor\'s Name',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // visitor phone textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: _phone,
                        validator: ValidationBuilder()
                            .minLength(11)
                            .maxLength(11)
                            .build(),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Visitor\'s Phone Number',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // visitor email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: _email,
                        validator: ValidationBuilder().email().build(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Visitor\'s Email (optional)',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // visitor purpose textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: _purpose,
                        validator: ValidationBuilder()
                            .minLength(3)
                            .maxLength(160)
                            .build(),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Purpose of Visiting',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // number of visitor textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextFormField(
                        controller: _visitorNo,
                        validator: ValidationBuilder()
                            .minLength(1)
                            .maxLength(2)
                            .build(),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Number of Visitor(s)',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // submit button
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    textStyle: GoogleFonts.nunitoSans(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: _validate,
                  icon: const Icon(Icons.key),
                  label: const Text('Generate Token'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
