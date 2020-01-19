import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:nano_weather/model/City.dart';
import 'package:nano_weather/model/NextDays.dart';
import 'package:nano_weather/module/ApiOpenWeather.dart';
import 'package:nano_weather/module/ListCity.dart';

class HomeBloc extends BlocBase {
  String cityDefault = "São Paulo";
  var apiOpenWeather;
  City city = City();
  int limitResults = 10;
  Position position;

  HomeBloc() {
    _searchController.stream.listen(_getData);
  }

  final StreamController<City> _cityController = StreamController<City>();
  Stream get getCity => _cityController.stream;

  final StreamController<String> _searchController = StreamController<String>();
  Sink get searchCity => _searchController.sink;

  void _getData(String chosenCity) {
    if (chosenCity.isEmpty)
      getDataByGeolocator();
    else
      _getDataByCity(chosenCity);
  }

  Future getDataByGeolocator() async {
    if (await _getGeolocate() == true) {
      try {
        apiOpenWeather = await ApiOpenWeather().getDataByGeolocator(
            position.latitude, position.longitude, limitResults);
        _setData();
      } catch (error) {
        print("ERRO: $error");
      }
    } else {
      await _getDataByCity(cityDefault);
    }
  }

  _getGeolocate() async {
    bool geolocationStatusIsEnabled =
        await Geolocator().isLocationServiceEnabled();

    if (geolocationStatusIsEnabled == true) {
      try {
        position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

        print("LONGITUDE: ${position.longitude}");
        print("LATITUDE: ${position.latitude}");
      } catch (e) {}
      if (position != null) return true;
    }
  }

  Future _getDataByCity(chosenCity) async {
    String codeCity;
    try {
      codeCity = _getIdCity(chosenCity);
    } catch (e) {
      await getDataByGeolocator();
    }
    try {
      apiOpenWeather =
          await ApiOpenWeather().getDataByCity(codeCity, limitResults);
      _setData();
    } catch (e) {
      print(e);
    }
  }

  _getIdCity(String city) {
    ListCity listaCity = ListCity();
    city = city.toLowerCase();
    var result = json.decode(listaCity.getJson);
    List lista = result["listCitys"];
    for (var i = 0; i < lista.length; i++) {
      if (lista[i]["name"].toString().toLowerCase().contains(city) == true) {
        print("ID Cidade: " + lista[i]["id"]);
        print("LONG Cidade: " + lista[i]["lon"]);
        print("LAT Cidade: " + lista[i]["lat"]);
        return lista[i]["id"];
      }
    }
  }

  _setData() {
    city.setName = apiOpenWeather["city"]["name"];
    city.setTemp = apiOpenWeather["list"][0]["main"]["temp"].toInt().toString();
    city.setTempMin =
        apiOpenWeather["list"][0]["main"]["temp_min"].toInt().toString();
    city.setTempMax =
        apiOpenWeather["list"][0]["main"]["temp_max"].toInt().toString();
    city.setHumidity = apiOpenWeather["list"][0]["main"]["humidity"].toString();
    city.setWindSpeedy =
        apiOpenWeather["list"][0]["wind"]["speed"].toString() + "km/h";
    city.setSunrise = _convertSunrise(apiOpenWeather["city"]["sunrise"]);
    city.setSunset = _convertSunset(apiOpenWeather["city"]["sunset"]);
    city.setDescription =
        apiOpenWeather["list"][0]["weather"][0]["description"];

    List<NextDay> nextDays = List<NextDay>();

    for (var i = 1; i < limitResults; i++) {
      NextDay nextDay = NextDay();

      nextDay.setDay = _getDateNextDays(i).toString();

      nextDay.setTemp =
          apiOpenWeather["list"][i]["main"]["temp"].toInt().toString();

      nextDay.setMax =
          apiOpenWeather["list"][i]["main"]["temp_max"].toInt().toString();
      nextDay.setMin =
          apiOpenWeather["list"][i]["main"]["temp_min"].toInt().toString();

      nextDay.setCondition =
          apiOpenWeather["list"][i]["weather"][0]["description"];
      nextDay.setConditionCod = apiOpenWeather["list"][i]["weather"][0]["id"];

      nextDays.add(nextDay);
    }

    city.setNextDay = nextDays;

    _cityController.sink.add(city);
  }

  _getDateNextDays(day) {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd');
    var formattedDate = int.parse(formatter.format(now));

    return formattedDate + day;
  }

  _convertSunrise(hour) {
    final df = DateFormat('hh:mm');
    int myValue = hour;

    return df.format(DateTime.fromMillisecondsSinceEpoch(myValue * 1000));
  }

  _convertSunset(hour) {
    DateFormat df = DateFormat('hh:mm');
    int myValue = hour;

    return df.format(new DateTime.fromMillisecondsSinceEpoch(myValue * 1000));
  }

  String getIconByCode(code) {
    if (code >= 200 && code <= 232) return "assets/iconsDark/7.png";
    if ((code >= 300 && code <= 321) || (code >= 520 && code <= 531))
      return "assets/iconsDark/5.png";
    if (code >= 500 && code <= 504) return "assets/iconsDark/6.png";
    if (code >= 600 && code <= 622 || code == 511)
      return "assets/iconsDark/8.png";
    if (code >= 701 && code <= 781) return "assets/iconsDark/9.png";
    if (code == 800) return "assets/iconsDark/1.png";
    if (code >= 801 && code <= 804) return "assets/iconsDark/2.png";

    return "assets/iconsDark/3.png";
  }

  @override
  void dispose() {
    super.dispose();
    _cityController.close();
    _searchController.close();
  }
}
