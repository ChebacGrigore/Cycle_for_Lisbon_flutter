import 'dart:convert';

import 'package:cfl/models/trip.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class TripService {
  final geolocator = GeolocatorPlatform.instance;

  Future<LatLng?> getCurrentLocation() async {
    LatLng? latLng;
    final permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final position = await geolocator.getCurrentPosition();
      latLng = LatLng(position.latitude, position.longitude);
    } else {
      getCurrentLocation();
    }
    return latLng;
  }

  Stream<Position> getLocationStream() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    return geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<Trip> uploadGPXFile(String token, String filePath) async {
    final url = Uri.parse('$baseUrl/trips');
    final request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);
        return Trip.fromJson(decodedResponse);
      } else {
        final responseBody = await response.stream.bytesToString();
        final decodedResponse = json.decode(responseBody);
        throw Exception('${decodedResponse['error']['code']}');
      }
    } catch (e) {
      throw Exception('File upload failed: $e');
    }
  }

  Future<List<TripModel>> getTrips({required String accessToken, DateTime? timeFrom, DateTime? timeTo}) async {
    final myUrl = '$baseUrl/trips?orderBy=id%20asc';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ssxxx");
    final formattedTimeFrom = timeFrom != null ? formatter.format(timeFrom) : null;
    final formattedTimeTo = timeTo != null ? formatter.format(timeTo) : null;



    final url = Uri.parse(myUrl).replace(queryParameters: {
      if (formattedTimeFrom != null) 'timeFrom': formattedTimeFrom,
      if (formattedTimeTo != null) 'timeTo': formattedTimeTo,
    });

    List<TripModel> trips = [];
    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (final trip in json) {
          trips.add(TripModel.fromJson(trip));
        }
        return trips;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    } catch (e) {
      print(e.toString());
      print(e.toString());
      throw Exception('$e');
    }
  }

  Future<List<POI>> fetchPOIs({required String token, required double maxLat, required double maxLon, required double minLat, required double minLon}) async {
    try{
      final url = Uri.parse(
          '$baseUrl/pois?maxLat=$maxLat&maxLon=$maxLon&minLat=$minLat&minLon=$minLon');

      final headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as List<dynamic>;
        final pois = jsonData.map((item) => POI.fromJson(item)).toList();
        return pois;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
