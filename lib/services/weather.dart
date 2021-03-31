import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

var appid = 'af5984c7f165ae1e44abbdeaafb41c43';

class WeatherModel {
  Future<dynamic> getcity(String city) async {
    var url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$appid';
    NetworkHelp networkHelp = NetworkHelp(url);
    var weatherdata = await networkHelp.getData();
    return weatherdata;
  }

  Future<dynamic> getLocation() async {
    Location location = Location();
    await location.getLocation();

    NetworkHelp networkhelper = NetworkHelp(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.lattitude}&lon=${location.longitude}&appid=$appid');
    var weatherdata = await networkhelper.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '☁️';
    } else if (condition == 800) {
      return '🌤️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
