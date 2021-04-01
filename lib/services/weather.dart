import 'package:clima_app/services/location.dart';
import '../services/networking.dart';

const apikey = 'de42a5da8e30e09aaf57de064193390d';
const owmUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String typedCity) async {
    NetworkHelper networkHelper =
        NetworkHelper('$owmUrl?q=$typedCity&appid=$apikey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        '$owmUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric'); //&units=metric are for celcius
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int cond) {
    if (cond < 300) {
      return '🌩';
    } else if (cond < 400) {
      return '🌧';
    } else if (cond < 600) {
      return '☔️';
    } else if (cond < 700) {
      return '☃️';
    } else if (cond < 800) {
      return '🌫';
    } else if (cond == 800) {
      return '☀️';
    } else if (cond <= 804) {
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
