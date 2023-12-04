import 'dart:convert';
import 'package:abahaoya/utils/api_url.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GlobalController extends GetxController {
  final RxBool _isLoading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  late RxString _temparatue = ''.obs;
  late RxString _humidity = ''.obs;
  late RxString _clouds = ''.obs;
  late RxString _wind= ''.obs;
  late RxString _windDirection= ''.obs;
  late RxString _icon= ''.obs;


  RxBool checkLoading() => _isLoading;
  RxDouble getLatitude() => _latitude;
  RxDouble getLongitude() => _longitude;
  RxString getTemp() => _temparatue;
  RxString getHumidity() => _humidity;
  RxString getClouds() => _clouds;
  RxString getWind() => _wind;
  RxString getwindDirection() => _windDirection;
  RxString getIcon() => _icon;



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
      // Accessing the "main" object and getting the "temp" value
      double temp = decoded['main']['temp'];
      _temparatue.value = (temp - 273.15).round().toString();
      _humidity.value = decoded['main']['humidity'].toString();
      _clouds.value = decoded['clouds']['all'].toString();
      _wind.value = decoded['wind']['speed'].toString();
       double WindDirection = decoded['wind']['speed'];
      _windDirection.value = getWindDirection(WindDirection);
      _icon.value = decoded['weather'][0]['icon'];

    } else {
      throw Exception('Failed to load weather data. Status code: ${response.statusCode}');
    }
  }

  String getWindDirection(double degree) {
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
