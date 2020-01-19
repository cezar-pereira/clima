import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:nano_weather/home/HomeBloc.dart';
import 'package:nano_weather/home/current-day-line-widget.dart';
import 'package:nano_weather/home/next-day-line-widget.dart';
import 'package:nano_weather/home/present-day-widget.dart';
import 'package:nano_weather/model/City.dart';
import 'package:nano_weather/ui/loading-widget.dart';

class HomePage extends StatelessWidget {
  final _fieldSearchController = TextEditingController();

  void _changeCity(city) {
    HomeBloc homeBloc = BlocProvider.getBloc<HomeBloc>();
    homeBloc.searchCity.add(city);
    _fieldSearchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc homeBloc = BlocProvider.getBloc<HomeBloc>();
    homeBloc.searchCity.add("maceio");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<City>(
        stream: homeBloc.getCity,
        builder: (context, AsyncSnapshot<City> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Loading("Carregando", "assets/cloud.flr", "Cloud");
              break;
            default:
              if (snapshot.hasData) {
                return home(snapshot.data, homeBloc);
              } else {
                return Loading("Erro", "assets/storm.flr", "Storm");
              }
          }
        },
      ),
    );
  }

  Widget home(City city, HomeBloc homeBloc) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black87,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.location_on),
                      onPressed: () {
                        homeBloc.getDataByGeolocator();
                      },
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Pesquisar cidade",
                      labelStyle: TextStyle(fontSize: 25),
                    ),
                    controller: _fieldSearchController,
                    onSubmitted: _changeCity,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: PresentDay(city),
          ),
          Column(
            children: <Widget>[
              Container(
                height: 100,
                child: CurrentDayLine(city),
              ),
              Divider(
                color: Colors.white24,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                height: 100,
                child: NextDayLine(city),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
