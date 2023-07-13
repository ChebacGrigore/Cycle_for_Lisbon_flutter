part of 'trip_bloc.dart';

abstract class TripEvent extends Equatable {
  const TripEvent();

  @override
  List<Object> get props => [];
}

class StartTrip extends TripEvent {
  const StartTrip();
  @override
  List<Object> get props => [];
}

class StopTrip extends TripEvent {
  final String token;
  // final String filePath;
  const StopTrip({required this.token});
  @override
  List<Object> get props => [token];
}

class GetPoints extends TripEvent {
  final String token;
  final String id;
  // final String filePath;
  const GetPoints({required this.token, required this.id});
  @override
  List<Object> get props => [token];
}

class GetLastRide extends TripEvent {
  final String token;
  final String id;
  // final String filePath;
  const GetLastRide({required this.token, required this.id});
  @override
  List<Object> get props => [token];
}

class AppListOfTrips extends TripEvent {
  final String token;
  final DateTime? timeFrom;
  final DateTime? timeTo;
  const AppListOfTrips({required this.token, this.timeFrom, this.timeTo});
  @override
  List<Object> get props => [token];
}

class AppListOfPOI extends TripEvent {
  final String token;
  final double maxLat;
  final double maxLon;
  final double minLat;
  final double minLon;

  const AppListOfPOI({required this.token, required this.maxLat, required this.maxLon, required this.minLat, required this.minLon, });
  @override
  List<Object> get props => [token, minLat, minLon, maxLon, maxLat];
}
