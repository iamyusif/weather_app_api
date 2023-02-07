import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_weather/havaEsas.dart';


class WeatherApiCilents {

  Future<Weather>havaOyren(String? yer) async {
    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$yer&lang=az&appid=759936c58eaf54de94d044e95c8bea4f&units=metric");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return Weather.fromJson(json);
  }
}