import 'package:cfl/models/trip.model.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum TripStatus {
  initial,
  loading,
  error,
  locationStream,
  allTrips,
  allPoi,
  allPoints,
  success,
  start,
  stop,
}

extension TripStatusX on TripStatus {
  bool get isInitial => this == TripStatus.initial;
  bool get isLoading => this == TripStatus.loading;
  bool get isAllTrips => this == TripStatus.allTrips;
  bool get isAllPoi => this == TripStatus.allPoi;
  bool get isAllPoints => this == TripStatus.allPoints;
  bool get isError => this == TripStatus.error;
  bool get isSuccess => this == TripStatus.success;
  bool get isLocationStream => this == TripStatus.locationStream;
  bool get isStart => this == TripStatus.start;
  bool get isStop => this == TripStatus.stop;
}

class TripState extends Equatable {
  const TripState({
    this.status = TripStatus.initial,
    this.exception,
    this.token,
    this.latitude,
    this.longitude,
    this.trip,
    this.trips = const [],
    this.pois = const [],
    this.points = const [],
  });

  final String? token;
  final String? exception;
  final TripStatus status;
  final double? latitude, longitude;
  final Trip? trip;
  final List<TripHistory>? trips;
  final List<POI>? pois;
  final List<LatLng>? points;

  TripState copyWith({
    TripStatus? status,
    String? exception,
    String? token,
    double? latitude,
    double? longitude,
    Trip? trip,
    List<TripHistory>? trips,
    List<POI>? pois,
    final List<LatLng>? points,
  }) {
    return TripState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      trip: trip ?? this.trip,
      trips: trips ?? this.trips,
      pois: pois ?? this.pois,
      points: points ?? this.points
    );
  }

  @override
  List<Object?> get props => [exception, status, token, latitude, longitude, points];
}
