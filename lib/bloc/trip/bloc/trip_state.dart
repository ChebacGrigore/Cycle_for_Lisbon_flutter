import 'package:cfl/models/trip.model.dart';
import 'package:equatable/equatable.dart';

enum TripStatus {
  initial,
  loading,
  error,
  locationStream,
  allTrips,
  success,
  start,
  stop,
}

extension TripStatusX on TripStatus {
  bool get isInitial => this == TripStatus.initial;
  bool get isLoading => this == TripStatus.loading;
  bool get isAllTrips => this == TripStatus.allTrips;
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
    this.trips,
  });

  final String? token;
  final String? exception;
  final TripStatus status;
  final double? latitude, longitude;
  final Trip? trip;
  final List<TripModel>? trips;

  TripState copyWith({
    TripStatus? status,
    String? exception,
    String? token,
    double? latitude,
    longitude,
    Trip? trip,
    List<TripModel>? trips,
  }) {
    return TripState(
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      trip: trip ?? this.trip,
      trips: trips ?? this.trips,
    );
  }

  @override
  List<Object?> get props => [exception, status, token, latitude, longitude];
}
