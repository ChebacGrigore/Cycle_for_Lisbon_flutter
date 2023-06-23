part of 'app_bloc.dart';

enum AppStatus {
  initial,
  error,
  loading,
  allInitiativesLoaded,
  selectedInitiative,
  completedInitiative,
  allBadges,
  allEntries,
}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isAllBadges => this == AppStatus.allBadges;
  bool get isEntries => this == AppStatus.allEntries;
  bool get isAllInitiativesLoaded => this == AppStatus.allInitiativesLoaded;
  bool get isSelectedInitiative => this == AppStatus.selectedInitiative;
  bool get isCompletedInitiative => this == AppStatus.completedInitiative;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.initiatives = const [],
    this.badges = const [],
    this.entries = const [],
    this.initiative,
    this.exception,
    this.token,
    this.userPosition,
  });

  final String? token;
  final String? exception;
  final List<Initiative> initiatives;
  final List<Entry> entries;
  final int? userPosition;
  final List<Badge> badges;
  final Initiative? initiative;
  final AppStatus status;

  AppState copyWith({
    List<Initiative>? initiatives,
    List<Entry>? entries,
    int? userPosition,
    AppStatus? status,
    Initiative? initiative,
    List<Badge>? badges,
    String? exception,
    String? token,
  }) {
    return AppState(
      initiatives: initiatives ?? this.initiatives,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      initiative: initiative ?? this.initiative,
      badges: badges ?? this.badges,
      entries: entries ?? this.entries,
      userPosition: userPosition ?? this.userPosition,
    );
  }

  @override
  List<Object?> get props =>
      [initiatives, exception, status, token, initiative, badges, entries];
}
