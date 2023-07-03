import 'dart:convert';
import 'dart:io';

import 'package:cfl/controller/app/initiative.dart';
import 'package:cfl/models/trip.model.dart';
import 'package:cfl/shared/configs/url_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:hex/hex.dart';
import 'package:path_provider/path_provider.dart';


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

  Future<String> downloadGpxFile(String id, String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };

    try{
      final response = await http.get(Uri.parse('$baseUrl/trips/$id/file'), headers: headers);

      if (response.statusCode == 200) {
        // Use path package to get the correct file path
        // String fullPath = path.join(filePath, 'file.gpx');
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'location_${DateTime.now().millisecondsSinceEpoch}.gpx';
        final filePath = '${directory.path}/$fileName';

        await File(filePath).writeAsBytes(response.bodyBytes);
        print('GPX file downloaded successfully.');

        // Read the content of the file
        File file = File(filePath);

        String fileContent = await file.readAsString();
        List<int> bytes = HEX.decode(fileContent.replaceAll(r'\x', ''));
        String xmlContent = utf8.decode(bytes);
        return xmlContent;
      } else {
        print('Error downloading GPX file. Status code: ${response.statusCode}');
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    }catch (e){
      print(e.toString());
      throw Exception('$e');
    }
  }

  List<LatLng> extractWaypoints(String gpxContent) {
    List<LatLng> waypoints = [];
    xml.XmlDocument document = xml.XmlDocument.parse(gpxContent);
    xml.XmlElement gpxElement = document.rootElement;

    for (var wptElement in gpxElement.findAllElements('trkpt')) {
      double lat = double.parse(wptElement.getAttribute('lat')!);
      double lon = double.parse(wptElement.getAttribute('lon')!);
      waypoints.add(LatLng(lat, lon));
    }
    for (var wptElement in gpxElement.findAllElements('wpt')) {
      double lat = double.parse(wptElement.getAttribute('lat')!);
      double lon = double.parse(wptElement.getAttribute('lon')!);
      waypoints.add(LatLng(lat, lon));
    }
    return waypoints;
  }

  String getTimeZone(DateTime dateTime) {
    final timeZoneOffset = dateTime.timeZoneOffset;
    final sign = timeZoneOffset.isNegative ? '-' : '+';
    final hours = timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    final minutes = timeZoneOffset.inMinutes.remainder(60).abs().toString().padLeft(2, '0');

    return '$sign$hours:$minutes';
  }

  Future<List<TripHistory>> getTrips({required String accessToken, DateTime? timeFrom, DateTime? timeTo}) async {
    final myUrl = '$baseUrl/trips?orderBy=id%20asc';
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss", "en_US");
    final formattedTimeFrom = timeFrom != null ? formatter.format(timeFrom) + getTimeZone(timeFrom) : null;
    final formattedTimeTo = timeTo != null ? formatter.format(timeTo) + getTimeZone(timeTo) : null;

    List<TripHistory> trips = [];
    try {
      final urlWithFilter = Uri.parse(myUrl).replace(queryParameters: {
        if (formattedTimeFrom != null) 'timeFrom': formattedTimeFrom,
        if (formattedTimeTo != null) 'timeTo': formattedTimeTo,
      });
      final url = Uri.parse(myUrl);
      final response = await http.get(timeFrom == null && timeTo == null ? url : urlWithFilter, headers: headers);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        for (final trip in json) {
          final tripModel = TripModel.fromJson(trip);
          if(tripModel.initiativeId != null){
            final initiative = await InitiativeService().getSingleInitiative(accessToken: accessToken, id: tripModel.initiativeId!);
            trips.add(TripHistory(trip: tripModel, initiativeName: initiative.title));
          }else{
            trips.add(TripHistory(trip: tripModel, initiativeName: ''));
          }
        }
        return trips;
      } else {
        final res = jsonDecode(response.body);
        throw Exception('${res['error']['message']}');
      }
    } catch (e) {
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
      print(response.body);

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
