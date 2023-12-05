import 'dart:convert';
import 'package:abahaoya/utils/api_url.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  late RxString _temparatue = ''.obs;
  late double _humidity = 0.0;
  late RxString _clouds = ''.obs;
  late RxString _wind= ''.obs;
  late RxString _windDirection= ''.obs;
  late RxString _icon= '01d'.obs;
  late RxString _main= ''.obs;
  late RxString _feelsLike= ''.obs;
  late RxString _pressure= ''.obs;
  late RxString _visibility= ''.obs;
  late RxString _sunriseTime= ''.obs;
  late RxString _sunsetTime= ''.obs;
  final timeFormat = DateFormat('h:mm a');


  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;
  RxString getTemp() => _temparatue;
  double getHumidity() => _humidity;
  RxString getClouds() => _clouds;
  RxString getWind() => _wind;
  RxString getwindDirection() => _windDirection;
  RxString getIcon() => _icon;
  RxString getMain() => _main;
  RxString getFeelsLike() => _feelsLike;
  RxString getPressure() => _pressure;
  RxString getVisibility() => _visibility;
  RxString getSunriseTime() => _sunriseTime;
  RxString getSunsetTime() => _sunsetTime;



  @override
  Future<void> onInit() async {
    if (_isLoading.isTrue) {
      await getLocation();
    }
    super.onInit();
  }
  processData(double lat, double lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    print(apiURL);
    if (response.statusCode == 200) {
      var decoded = json.decode(response.body);
      double temp = decoded['main']['temp'];
      _temparatue.value = (temp - 273.15).round().toString();
      double temp2 = decoded['main']['feels_like'];
      _feelsLike.value = (temp2 - 273.15).round().toString();
      _humidity = decoded['main']['humidity'].toDouble();
      _clouds.value = decoded['clouds']['all'].toString();
      double temp3= decoded['wind']['speed'];
      _wind.value = (temp3 * 3.6).round().toString(); // Convert to km/h
       int WindDirection = decoded['wind']['deg'];
      _windDirection.value = getWindDirection(WindDirection);
      _icon.value = decoded['weather'][0]['icon'];
      _main.value = decoded['weather'][0]['main'];
      _pressure.value = decoded['main']['pressure'].toString();

      int sunriseTimestamp = decoded['sys']['sunrise'];
      int sunsetTimestamp = decoded['sys']['sunset'];
      DateTime sunriseTime = DateTime.fromMillisecondsSinceEpoch(sunriseTimestamp * 1000, isUtc: true);
      DateTime sunsetTime = DateTime.fromMillisecondsSinceEpoch(sunsetTimestamp * 1000, isUtc: true);
      DateTime localSunriseTime = sunriseTime.toLocal();
      DateTime localSunsetTime = sunsetTime.toLocal();
      _sunriseTime.value = timeFormat.format(localSunriseTime).toString();
      _sunsetTime.value = timeFormat.format(localSunsetTime).toString();
      int visibilityInMeters = decoded['visibility'];
      _visibility.value = (visibilityInMeters / 1000.0).toString();

    } else {
      throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
    }
  }

  String getWindDirection(int degree) {
    if (degree >= 337.5 || degree < 22.5) {
      return 'North';
    } else if (degree >= 22.5 && degree < 67.5) {
      return 'Northeast';
    } else if (degree >= 67.5 && degree < 112.5) {
      return 'East';
    } else if (degree >= 112.5 && degree < 157.5) {
      return 'Southeast';
    } else if (degree >= 157.5 && degree < 202.5) {
      return 'South';
    } else if (degree >= 202.5 && degree < 247.5) {
      return 'Southwest';
    } else if (degree >= 247.5 && degree < 292.5) {
      return 'West';
    } else {
      return 'Northwest';
    }
  }

  Future<void> getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      throw Exception("Location not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      throw Exception("Location permission is denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        throw Exception("Location permission is denied");
      }
    }

    try {
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _latitude.value = position.latitude;
      _longitude.value = position.longitude;
      processData(_latitude.value, _longitude.value);
      _isLoading.value = false;
    } catch (e) {
      print("Error fetching weather data: $e");
      _isLoading.value = false;
      throw Exception("Error fetching weather data");
    }
  }
}
