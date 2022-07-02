import 'dart:convert';

import 'package:resident_app/const/api_constants.dart';
import 'package:http/http.dart' as http;

login(
  String email,
  String password,
) async {
  final response = await http.post(
    Uri.parse(ApiConstants.baseUrl + ApiConstants.complaintsEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );
}
