import 'package:flutter/material.dart';
import 'package:weather/screens/locationnew.dart';

import 'package:weather/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

var appid = 'af5984c7f165ae1e44abbdeaafb41c43';

class Screen1 extends StatefulWidget {
  @override
  _Screen1State createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  var weatherinfo;
  void getLocation() async {
    WeatherModel weatherModel = WeatherModel();
    weatherinfo = await weatherModel.getLocation();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        locationdata: weatherinfo,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    //getData();
    return Scaffold(
      body: Center(
        child: SpinKitCubeGrid(
          color: Colors.blueAccent,
          size: 100,
        ),
      ),
    );
  }
}
