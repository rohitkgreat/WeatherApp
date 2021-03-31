import 'package:flutter/material.dart';
import 'package:weather/screens/city.dart';
import 'package:weather/utilities/constants.dart';
import 'package:weather/services/weather.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        return;
      }
      condition = weatherdata['weather'][0]['id'];
      double temp = weatherdata['main']['temp'];
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
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      cityname = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
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
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$tempr °',
                      style: kTempTextStyle,
                    ),
                    Text(
                      icon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$icon2 in $city',
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
