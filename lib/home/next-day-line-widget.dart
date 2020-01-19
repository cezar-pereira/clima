import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nano_weather/home/HomeBloc.dart';
import 'package:nano_weather/model/City.dart';

class NextDayLine extends StatelessWidget {
  City city = City();
  MediaQueryData mediaQuery;
  NextDayLine(this.city);
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);

    HomeBloc homeBloc = BlocProvider.getBloc<HomeBloc>();
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: city.getNextDay.length,
      itemBuilder: (context, index) {
        return Container(
          width: mediaQuery.size.width / 4,
          child: FlatButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return buildDialog(index);
                  });
            },
            child: Column(
              children: <Widget>[
                Text(
                  city.getNextDay[index].getDay,
                  style: TextStyle(fontSize: mediaQuery.size.width * 0.07),
                ),
                Image.asset(
                  homeBloc
                      .getIconByCode(city.getNextDay[index].getConditionCod),
                  height: 40,
                  width: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "▼" + city.getNextDay[index].getMin,
                      style: TextStyle(fontSize: mediaQuery.size.width * 0.035),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Text(""),
                    ),
                    Text(
                      "▲" + city.getNextDay[index].getMax,
                      style: TextStyle(fontSize: mediaQuery.size.width * 0.035),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildDialog(index) {
    return AlertDialog(
      content: Container(
        height: mediaQuery.size.width * 0.75,
        width: mediaQuery.size.width * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              city.getNextDay[index].getCondition,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: mediaQuery.size.width * 0.08,
                  letterSpacing: 10),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              city.getNextDay[index].getTem + "°C",
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: mediaQuery.size.width * 0.15),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Mín: " + city.getNextDay[index].getMin,
                  style: TextStyle(fontSize: mediaQuery.size.width * 0.04),
                ),
                Text(" | "),
                Text(
                  "Máx: " + city.getNextDay[index].getMax,
                  style: TextStyle(fontSize: mediaQuery.size.width * 0.04),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
