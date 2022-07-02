import 'package:shared_preferences/shared_preferences.dart';

// Get
Future prefGetBool(prefKey) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  final val = pref.getBool(prefKey);
  prefKey = val;
}

Future prefGetInt(prefKey) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.getInt(prefKey);
}

Future prefGetString(prefKey) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.getString(prefKey);
}

Future prefGetDouble(prefKey) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.getDouble(prefKey);
}

// Save
Future prefSaveInt(String prefKey, prefVal) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setInt(prefKey, prefVal);
}

Future prefSaveString(String prefKey, prefVal) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString(prefKey, prefVal);
}

Future prefSaveBool(String prefKey, prefVal) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setBool(prefKey, prefVal);
}

Future prefSaveDouble(String prefKey, prefVal) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setDouble(prefKey, prefVal);
}

// Remove
Future deletePref(String prefKey) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.remove(prefKey);
}
