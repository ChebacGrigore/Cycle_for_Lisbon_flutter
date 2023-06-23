part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppListOfInitiatives extends AppEvent {
  final String token;
  const AppListOfInitiatives({required this.token});
  @override
  List<Object> get props => [token];
}

class AppSelectedInitiative extends AppEvent {
  final Initiative initiative;
  const AppSelectedInitiative({required this.initiative});
  @override
  List<Object> get props => [initiative];
}

class AppCompletedInitiative extends AppEvent {
  final Initiative initiative;
  const AppCompletedInitiative({required this.initiative});
  @override
  List<Object> get props => [initiative];
}

class AppListOfBadges extends AppEvent {
  final String token;
  const AppListOfBadges({required this.token});
  @override
  List<Object> get props => [token];
}

class AppLeaderboard extends AppEvent {
  final String token;
  const AppLeaderboard({required this.token});
  @override
  List<Object> get props => [token];
}
