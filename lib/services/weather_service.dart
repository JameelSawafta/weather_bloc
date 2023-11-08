import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_bloc/services/keys.dart';

class WeatherService{

  String apiKey = Keys().apiKey;


  Future getData({required cityName}) async{

    Map<String, dynamic>? responseBody;

    Uri url = Uri.parse("https://api.weatherapi.com/v1/current.json?key=${apiKey}&q=${cityName}&aqi=no");
    var response = await http.get(url);

    if (response.statusCode != 200){
      responseBody = json.decode(response.body);
      throw Exception("${responseBody?["error"]["message"]}");
    }
    responseBody = json.decode(response.body);

    return responseBody;
  }
}