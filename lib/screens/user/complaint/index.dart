import 'package:resident_app/service/complaint.dart';
import 'package:resident_app/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateComplaintScreen extends StatefulWidget {
  String title;
  CreateComplaintScreen({super.key, required this.title});

  @override
  State<CreateComplaintScreen> createState() => _CreateComplaintScreenState();
}

class _CreateComplaintScreenState extends State<CreateComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _message = TextEditingController();

  void _validate() {
    bool validate = _formKey.currentState!.validate();
    final _inputSubject = _subject.text;
    final _inputMessage = _message.text;

    if (validate) {
      createComplaint(context, _inputSubject, _inputMessage)
          .then((value) => _formKey.currentState!.reset());
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
              children: [
                // subject textfield
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
                        controller: _subject,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Subject',
                        ),
                        validator: ValidationBuilder()
                            .minLength(3)
                            .maxLength(50)
                            .build(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // message textfield
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
                        controller: _message,
                        minLines: 6,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write something here...',
                        ),
                        validator: ValidationBuilder()
                            .minLength(3)
                            .maxLength(500)
                            .build(),
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
                  icon: const Icon(Icons.arrow_forward_ios),
                  label: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
