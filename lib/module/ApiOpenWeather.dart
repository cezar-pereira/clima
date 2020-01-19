import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiOpenWeather {
  static const apiKey = "d3b1e2103a914c23183aebb308fd40d0";

  Future<Map> getDataByCity(cityCode, limitResults) async {
    
    final request =
        "http://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&id=$cityCode&cnt=$limitResults&lang=pt&units=metric";

    http.Response response = await http.get(request);
    //print("Dados> " + response.body);
    return json.decode(response.body);
  }

  Future<Map> getDataByGeolocator(latitude, longitude, limitResults) async {
    final request =
        "http://api.openweathermap.org/data/2.5/forecast?appid=$apiKey&lat=$latitude&lon=$longitude&cnt=$limitResults&lang=pt&units=metric";

    http.Response response = await http.get(request);
    //print("Dados> "+response.body);

    return json.decode(response.body);
  }
}
