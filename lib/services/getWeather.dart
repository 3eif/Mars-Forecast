import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'getKey.dart';

Future getWeather() async {
  String apiKey = await getKey();
  http.Response websitesResponse = await http.get(
      'https://api.nasa.gov/insight_weather/?api_key=$apiKey&feedtype=json&ver=1.0');
  dynamic websitesData = json.decode(websitesResponse.body);
  return websitesData;
}
