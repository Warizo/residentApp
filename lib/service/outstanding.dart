import 'dart:async';
import 'dart:convert';

import 'package:resident_app/const/api_constants.dart';
import 'package:resident_app/models/outstanding.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Outstanding>> fetchOutstandings() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final String fullId = prefs.getString("residenceID")!;
  final String residentID = fullId.substring(1);
  Map<String, String> queryParams = {
    "residentID": residentID,
  };

  final url =
      Uri.parse(ApiConstants.baseUrl + ApiConstants.outstandingsEndpoint)
          .replace(queryParameters: queryParams);

  final response = await http.get(url);
  if (response.statusCode == 200) {
    return parseOutstandings(response.body);
  } else {
    throw Exception("Unable to fetch your outstandings");
  }
}

List<Outstanding> parseOutstandings(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Outstanding>((json) => Outstanding.fromJson(json)).toList();
}
