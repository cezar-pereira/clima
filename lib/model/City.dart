import 'package:nano_weather/model/NextDays.dart';

class City {
  String _name;
  String _temp;
  String _tempMin;
  String _tempMax;
  String _humidity;
  String _windSpeedy;
  String _sunrise;
  String _sunset;
  String _description;
  List<NextDay> _nextDays = List<NextDay>();

  get getName => _name;

  set setName(name) {
    this._name = name;
  }

  get getTemp => _temp;

  set setTemp(temp) {
    this._temp = temp;
  }

  get getTempMin => _tempMin;

  set setTempMin(tempMin) {
    this._tempMin = tempMin;
  }

  get getTempMax => _tempMax;

  set setTempMax(tempMax) {
    this._tempMax = tempMax;
  }

  get getHumidity => _humidity;

  set setHumidity(_humidity) {
    this._humidity = _humidity;
  }

  get getWindSpeedy => _windSpeedy;

  set setWindSpeedy(windSpeedy) {
    this._windSpeedy = windSpeedy;
  }

  get getSunrise => _sunrise;

  set setSunrise(sunrise) {
    this._sunrise = sunrise;
  }

  get getSunset => _sunset;

  set setSunset(sunset) {
    this._sunset = sunset;
  }

  get getNextDay => _nextDays;

  set setNextDay(nextDay) {
    this._nextDays = nextDay;
  }

  get getDescription => _description;

  set setDescription(description) {
    this._description = description;
  }
}
