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

class AppChangeInitiative extends AppEvent {
  const AppChangeInitiative();
  @override
  List<Object> get props => [];
}

class AppCompletedInitiative extends AppEvent {
  final Initiative initiative;
  const AppCompletedInitiative({required this.initiative});
  @override
  List<Object> get props => [initiative];
}

class AppSupportInitiative extends AppEvent {
  const AppSupportInitiative({
    required this.token,
    required this.userProfile,
    required this.userId,
    required this.initiativeId,
  });
  final String token;
  final String userId;
  final String initiativeId;
  final User userProfile;
  // @override
  // List<Object?> get props => [token, userProfile, userId, initiativeId];
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

class AppNews extends AppEvent {
  final String token;
  const AppNews({required this.token});
  @override
  List<Object> get props => [token];
}

class AppEvents extends AppEvent {
  final String token;
  const AppEvents({required this.token});
  @override
  List<Object> get props => [token];
}