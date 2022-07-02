import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:resident_app/models/user.dart';
import 'package:resident_app/route/routing_constant.dart';
import 'package:resident_app/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:form_validator/form_validator.dart';
import 'package:resident_app/const/api_constants.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  bool isLoading = true;

  dynamic responsne;

  bool residentLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  _validate() {
    bool validate = _form.currentState!.validate();
    String _email = email.text;
    String _password = password.text;

    if (validate) {
      residentLogin(_email, _password);
      if (responsne != null) {
        if (responsne[0]["status"]) {
          Navigator.pushReplacementNamed(context, DashboardScreenRoute);
        } else {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            text: responsne[0]["message"],
          ).then((_) => _form.currentState!.reset());
        }
      }
    }
  }

  Future residentLogin(
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var userApi = jsonDecode(response.body);

      if (userApi[0]["status"] == true) {
        String fullId = userApi[0]["user"]["ResidenceID"];
        String residentID = fullId.substring(1);
        Map<String, String> queryParams = {
          "residentID": residentID,
        };
        final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.userEndpoint)
            .replace(queryParameters: queryParams);

        final profileResponse = await http.get(url);

        if (profileResponse.statusCode == 200) {
          var profileApi = jsonDecode(profileResponse.body);

          if (profileApi[0]["status"] == true) {
            prefSaveString("surname", profileApi[0]["profile"]["Surname"]);
            prefSaveString("firstname", profileApi[0]["profile"]["FirstName"]);
            prefSaveString("phone", profileApi[0]["profile"]["PhoneNumber"]);
            prefSaveString("dob", profileApi[0]["profile"]["DOB"]["date"]);
            prefSaveString(
                "address", profileApi[0]["profile"]["EstateAddress"]);
            prefSaveString(
                "apartment", profileApi[0]["profile"]["ApartmentInfo"]);
            prefSaveString("zone", profileApi[0]["profile"]["Zone"]);
          }
        } else {
          print(response.statusCode);
          throw Exception("Error: Unable to connect to Profile API");
        }
        prefSaveString("residenceID", userApi[0]["user"]["ResidenceID"]);
        prefSaveString("email", userApi[0]["user"]["Email"]);
        prefSaveBool("isLoggedIn", true);
        userFromJson(response.body);
        if (mounted) {
          setState(() {
            responsne = userApi;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            responsne = userApi;
          });
        }
      }
    } else {
      print(response.statusCode);
      throw Exception("Error: Unable to connect to Login API");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.deepPurple[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Logo
                  Image.asset(
                    'assets/images/romakop_logo.png',
                    width: MediaQuery.of(context).size.width / 1.5,
                  ),
                  const SizedBox(height: 20),

                  // APP Name
                  Text(
                    'MAGODO',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 52,
                      color: Colors.white,
                      letterSpacing: 2.5,
                    ),
                  ),
                  Text(
                    'SOUTH EAST ZONE',
                    style: GoogleFonts.bebasNeue(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Welcome back, enter your login details below.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // email textfield
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
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                          validator:
                              ValidationBuilder().email().maxLength(50).build(),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // password textfield
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
                          keyboardType: TextInputType.name,
                          controller: password,
                          obscureText: true,
                          validator: ValidationBuilder()
                              .minLength(3)
                              .maxLength(50)
                              .build(),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
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
                    onPressed: () {
                      _validate();
                    },
                    icon: const Icon(Icons.arrow_forward_ios),
                    label: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
