import 'dart:async';
import 'dart:convert';

import 'package:resident_app/const/api_constants.dart';
import 'package:resident_app/models/vendor.dart';
import 'package:http/http.dart' as http;

Future<List<Vendor>> fetchVendors() async {
  var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.vendorsEndpoint);
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return parseVendors(response.body);
  } else {
    throw Exception("Unable to fetch vendors");
  }
}

List<Vendor> parseVendors(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Vendor>((json) => Vendor.fromJson(json)).toList();
}
