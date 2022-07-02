import 'dart:async';
import 'dart:convert';

import 'package:resident_app/route/routing_constant.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:resident_app/const/api_constants.dart';
import 'package:resident_app/models/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Token>> fetchTokens() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String fullId = prefs.getString("residenceID")!;
  final String residentID = fullId.substring(1);
  Map<String, String> queryParams = {
    "residentID": residentID,
  };

  final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.tokensEndpoint)
      .replace(queryParameters: queryParams);

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return parseTokens(response.body);
  } else {
    throw Exception("Unable to connect to token api");
  }
}

List<Token> parseTokens(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Token>((json) => Token.fromJson(json)).toList();
}

Future postToken(context, dynamic data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String fullId = prefs.getString("residenceID")!;
  final String surname = prefs.getString("surname")!;
  final String firstname = prefs.getString("firstname")!;
  final String address = prefs.getString("address")!;

  final response = await http.post(
    Uri.parse(ApiConstants.baseUrl + ApiConstants.tokensEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'residentID': fullId,
      'residentName': "$surname $firstname",
      'residentAddress': address,
      'visitorName': data['visitorName'],
      'visitorEmail': data['visitorEmail'],
      'visitorNo': data['visitorNo'],
      'reason': data['reason'],
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then decode the JSON.

    var result = response.body;
    var _result = jsonDecode(result);

    if (_result[0]['status']) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: "${_result[0]['message']}",
      ).then((value) => Navigator.pushNamed(context, TokenScreenRoute));
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: "$result[0]['message']",
      );
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create complaint. API Connection Failed');
  }
}
