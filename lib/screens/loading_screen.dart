import 'package:flutter/material.dart';
import 'package:clima_app/services/location.dart';
import '../services/networking.dart';
import '../screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = 'de42a5da8e30e09aaf57de064193390d'; //use my apikey for free

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$apikey&units=metric'); //&units=metric are for celcius
    var weatherData = await networkHelper.getData();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  void getData() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
