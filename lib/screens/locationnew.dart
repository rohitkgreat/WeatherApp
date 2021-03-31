//import 'dart:html';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather/screens/city.dart';
//import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationdata});
  final locationdata;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

var condition;
int tempr;
String city;
WeatherModel weathericon = WeatherModel();
String icon;
String icon2;
String cityname;
String feels;
int humid;
int wind;
int press;

class _LocationScreenState extends State<LocationScreen> {
  @override
  void initState() {
    super.initState();
    updateUi(widget.locationdata);
  }

  void updateUi(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        tempr = 0;
        city = "Error";
        icon = 'Error';
        icon2 = 'Error';
        feels = "";
        humid = 0;
        wind = 0;
        press = 0;

        return;
      }
      condition = weatherdata['weather'][0]['id'];
      feels = weatherdata['weather'][0]['description'];
      double temp = weatherdata['main']['temp'];
      humid = weatherdata['main']['humidity'];
      double windi = weatherdata['wind']['speed'];
      press = weatherdata['main']['pressure'];
      // press = pres.toInt();
      wind = windi.toInt();
      // humid = humidi.toInt();
      tempr = temp.toInt();
      city = weatherdata['name'];
      tempr = tempr - 273;
      temp.roundToDouble();
      icon = weathericon.getWeatherIcon(condition);
      icon2 = weathericon.getMessage(tempr);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherdata = await weathericon.getLocation();
                      updateUi(weatherdata);
                    },
                    child: Icon(
                      FontAwesomeIcons.crosshairs,
                      //color: Colors.black,
                      size: 40.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      cityname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen(
                                // weather: ,
                                );
                          },
                        ),
                      );
                      if (cityname != null) {
                        var newdata = await weathericon.getcity(cityname);
                        updateUi(newdata);
                      }
                    },
                    child: Icon(
                      Icons.search,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      ' $tempr°',
                      style: TextStyle(fontSize: 140, fontFamily: 'Redressed'),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(150, 40, 0, 80),
                  child: Container(
                    child: Text('$feels $icon ',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'Redressed',
                        )),
                  ),
                ),
              ),
              GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.smog,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          //'Hello',
                          '${wind}m/s',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.tachometerAlt,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('${press}Pa', style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.tint,
                          size: 40,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('${humid}g/m', style: TextStyle(fontSize: 20)),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 60,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '$city',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 70, fontFamily: 'Dancing'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
