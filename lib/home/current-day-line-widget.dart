import 'package:flutter/material.dart';
import 'package:nano_weather/model/City.dart';

class CurrentDayLine extends StatelessWidget {
  City city = City();

  CurrentDayLine(this.city);
  MediaQueryData mediaQuery;

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return Row(
      children: <Widget>[
        Expanded(
            child: buildCurrentDayItem("Vel. do vento", city.getWindSpeedy)),
        verticalLine(),
        Expanded(child: buildCurrentDayItem("Nascer do sol", city.getSunrise)),
        verticalLine(),
        Expanded(child: buildCurrentDayItem("Por do sol", city.getSunset)),
        verticalLine(),
        Expanded(child: buildCurrentDayItem("Humidade", city.getHumidity)),
      ],
    );
  }

  Widget buildCurrentDayItem(title, information) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 17, bottom: 10),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: mediaQuery.size.width * 0.04, color: Colors.white70),
          ),
        ),
        Text(information,
            style: TextStyle(
              fontSize: mediaQuery.size.width * 0.04,
              color: Colors.white,
            )),
      ],
    );
  }

  Widget verticalLine() {
    return Container(
      height: 60,
      width: 0.5,
      color: Colors.white,
      child: Text(""),
    );
  }
}
