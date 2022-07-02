import 'dart:async';
import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:resident_app/const/api_constants.dart';
import 'package:resident_app/models/complaint.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Complaint>> fetchComplaints() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String fullId = prefs.getString("residenceID")!;
  final String residentID = fullId.substring(1);
  Map<String, String> queryParams = {
    "residentID": residentID,
  };

  final url = Uri.parse(ApiConstants.baseUrl + ApiConstants.complaintsEndpoint)
      .replace(queryParameters: queryParams);

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return parseComplaints(response.body);
  } else {
    print(response.statusCode);
    throw Exception("Unable to fetch complaints");
  }
}

List<Complaint> parseComplaints(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Complaint>((json) => Complaint.fromJson(json)).toList();
}

Future createComplaint(context, String subject, String message) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String fullId = prefs.getString("residenceID")!;

  final response = await http.post(
    Uri.parse(ApiConstants.baseUrl + ApiConstants.complaintsEndpoint),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'residentID': fullId,
      'subject': subject,
      'complaint': message,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responsne = jsonDecode(response.body);
    if (responsne[0]["status"]) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.success,
        text: responsne[0]['message'],
      );
    } else {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: responsne[0]['message'],
      );
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to connect to complaint api');
  }
}
