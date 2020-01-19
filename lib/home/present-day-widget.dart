import 'package:flutter/material.dart';
import 'package:nano_weather/model/City.dart';

class PresentDay extends StatelessWidget {
  MediaQueryData mediaQuery;
  bool dpiIsBig = false;
  City city = City();
  PresentDay(this.city);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    _dpiIsBig(screenSize.width, screenSize.height);
    mediaQuery = MediaQuery.of(context);

    return Column(
      children: <Widget>[
        Text(
          city.getName,
          style: TextStyle(
              fontSize: mediaQuery.size.width * 0.17,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(city.getDescription,
            style: TextStyle(fontSize: mediaQuery.size.width * 0.08)),
        Text(city.getTemp + "°C",
            style: TextStyle(
                fontSize: mediaQuery.size.width * 0.15,
                fontWeight: FontWeight.w200)),
        minAndMax(),
      ],
    );
  }

  Widget minAndMax() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("Mín: "+ city.getTempMin  + "°C",
            style: TextStyle(fontSize: mediaQuery.size.width * 0.05)),
        Text(
          " | ",
          style: TextStyle(fontSize: mediaQuery.size.width * 0.05),
        ),
        Text("Máx: " + city.getTempMax + "°C",
            style: TextStyle(fontSize: mediaQuery.size.width * 0.05)),
      ],
    );
  }

  _dpiIsBig(width, height) {
    if (width >= 500 && height >= 1000) dpiIsBig = true;
  }
}
