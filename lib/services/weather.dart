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
      return '๐ฉ';
    } else if (cond < 400) {
      return '๐ง';
    } else if (cond < 600) {
      return 'โ๏ธ';
    } else if (cond < 700) {
      return 'โ๏ธ';
    } else if (cond < 800) {
      return '๐ซ';
    } else if (cond == 800) {
      return 'โ๏ธ';
    } else if (cond <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
