import 'dart:async';
import 'dart:io';

import 'package:cfl/controller/app/trip_service.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_state.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gpx/gpx.dart';
import 'package:path_provider/path_provider.dart';

part 'trip_event.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  StreamSubscription<Position>? _positionSubscription;
  final TripService _trip = TripService();
  Gpx gpx = Gpx();
  TripBloc() : super(const TripState()) {
    on<StartTrip>(_onTripStarted);
    on<StopTrip>(_onTripStop);
    on<AppListOfTrips>(_onListOfTrips);
    on<AppListOfPOI>(_onListOfPois);
  }

  void _onListOfTrips(AppListOfTrips event, Emitter<TripState> emit) async {
    emit(state.copyWith(status: TripStatus.loading));
    try {
      final trips = await _trip.getTrips(
        accessToken: event.token,
        timeFrom: event.timeFrom,
        timeTo: event.timeTo,
      );
      print(trips);
      emit(
        state.copyWith(
          status: TripStatus.allTrips,
          trips: trips,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: TripStatus.error));
    }
  }

  void _onListOfPois(AppListOfPOI event, Emitter<TripState> emit) async {
    emit(state.copyWith(status: TripStatus.loading));
    try {
      final pois = await _trip.fetchPOIs(
        token: event.token,
        maxLat: currentLocation.latitude + 1,
        maxLon: currentLocation.longitude + 1,
        minLat: currentLocation.latitude -2,
        minLon: currentLocation.longitude -2,
      );
      emit(
        state.copyWith(
          status: TripStatus.allPoi,
          pois: pois,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: TripStatus.error));
    }
  }

  void _onTripStarted(StartTrip event, Emitter<TripState> emit) async {
    emit(state.copyWith(status: TripStatus.start));
    await _trip.requestLocationPermission();
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );
    try {
      _positionSubscription?.cancel();
      _positionSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (position) {
              final waypoint = Wpt(
                lat: position.latitude,
                lon: position.longitude,
                ele: position.altitude,
                time: DateTime.now(),
              );
              print(waypoint);
              gpx.wpts.add(waypoint);
          emit(state.copyWith(status: TripStatus.locationStream,latitude: position.latitude, longitude: position.longitude));
        },
      );
      // await for (Position position
      //     in Geolocator.getPositionStream(locationSettings: locationSettings)) {
      //   final waypoint = Wpt(
      //     lat: position.latitude,
      //     lon: position.longitude,
      //     ele: position.altitude,
      //     time: DateTime.now(),
      //   );
      //   gpx.wpts.add(waypoint);
      //   print(waypoint);
      // }
    } catch (e) {
      emit(state.copyWith(status: TripStatus.error, exception: e.toString()));
    }
  }

  void _onTripStop(StopTrip event, Emitter<TripState> emit) async {
    _positionSubscription?.cancel();
    emit(state.copyWith(status: TripStatus.loading));
    emit(state.copyWith(status: TripStatus.stop));
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'location_${DateTime.now().millisecondsSinceEpoch}.gpx';
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      final gpxString = GpxWriter().asString(gpx, pretty: true);
      await file.writeAsString(gpxString);
      print(gpxString);
      final trip = await _trip.uploadGPXFile(event.token, file.path);
      emit(state.copyWith(status: TripStatus.success, trip: trip));
    } catch (e) {
      emit(state.copyWith(status: TripStatus.error, exception: e.toString()));
    }
  }
}
