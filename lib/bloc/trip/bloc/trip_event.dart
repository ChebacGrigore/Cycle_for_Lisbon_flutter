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

class AppListOfTrips extends TripEvent {
  final String token;
  const AppListOfTrips({required this.token});
  @override
  List<Object> get props => [token];
}
