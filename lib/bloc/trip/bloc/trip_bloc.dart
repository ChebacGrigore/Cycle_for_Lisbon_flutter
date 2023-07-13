import 'dart:io';

import 'package:cfl/controller/app/trip_service.dart';
import 'package:cfl/controller/auth/auth.dart';
import 'package:cfl/models/trip.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_state.dart';
import 'package:equatable/equatable.dart';
import 'package:gpx/gpx.dart';
import 'package:path_provider/path_provider.dart';

import '../../../shared/global/global_var.dart';

part 'trip_event.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  // StreamSubscription<Position>? _positionSubscription;
  // final TripService _trip = TripService();
  Gpx gpx = Gpx();
  TripBloc() : super(const TripState()) {
    // on<StartTrip>(_onTripStarted);
    on<StopTrip>(_onTripStop);
    on<AppListOfTrips>(_onListOfTrips);
    on<AppListOfPOI>(_onListOfPois);
    on<GetPoints>(_onListOfPoints);
    on<GetLastRide>(_onLastRide);
  }

  void _onListOfTrips(AppListOfTrips event, Emitter<TripState> emit) async {
    emit(state.copyWith(status: TripStatus.loading));
    try {
      final trips = await tripService.getTrips(
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
      print(event.maxLat);
      final pois = await tripService.fetchPOIs(
        token: event.token,
        maxLat: event.maxLat,
        maxLon: event.maxLon,
        minLat: event.minLat,
        minLon: event.minLon,
      );
      emit(
        state.copyWith(
          status: TripStatus.allPoi,
          pois: pois,
        ),
      );
    } catch (e, sta) {
      print(sta);
      emit(state.copyWith(exception: e.toString(), status: TripStatus.error));
    }
  }

  void _onListOfPoints(GetPoints event, Emitter<TripState> emit) async {
    emit(state.copyWith(status: TripStatus.loading));
    try {
      final gpxContent =
          await tripService.downloadGpxFile(event.id, event.token);
      final points = tripService.extractWaypoints(gpxContent);
      emit(
        state.copyWith(
          status: TripStatus.allPoi,
          points: points,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: TripStatus.error));
    }
  }

  void _onLastRide(GetLastRide event, Emitter<TripState> emit) async {
    emit(state.copyWith(status: TripStatus.loading));
    try {
      final gpxContent =
          await tripService.downloadGpxFile(event.id, event.token);
      final points = tripService.extractWaypoints(gpxContent);
      final trip = await tripService.getSingleTrip(
          accessToken: event.token, id: event.id);
      emit(
        state.copyWith(
          status: TripStatus.lastRide,
          lastRide: LastRide(trip: trip, points: points),
        ),
      );
    } catch (e, s) {
      print(s);
      emit(state.copyWith(exception: e.toString(), status: TripStatus.error));
    }
  }

  void _onTripStop(StopTrip event, Emitter<TripState> emit) async {
    tripService.positionSubscription?.cancel();
    // emit(state.copyWith(status: TripStatus.stop));
    emit(state.copyWith(status: TripStatus.tripUploading));
    try {
      gpx.trks.add(
        Trk(
          name: currentUser.initiative!.title,
          trksegs: [Trkseg(trkpts: tripService.trkpts)],
        ),
      );
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'location_${DateTime.now().millisecondsSinceEpoch}.gpx';
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      final gpxString = GpxWriter().asString(gpx, pretty: true);
      await file.writeAsString(gpxString);
      print(gpxString);
      final trip = await tripService.uploadGPXFile(event.token, file.path);
      await auth.saveToLocalStorage(key: 'tripId', value: trip.id);
      emit(state.copyWith(status: TripStatus.success, trip: trip));
    } catch (e, s) {
      print(s);
      emit(state.copyWith(status: TripStatus.error, exception: e.toString()));
    }
  }
}
