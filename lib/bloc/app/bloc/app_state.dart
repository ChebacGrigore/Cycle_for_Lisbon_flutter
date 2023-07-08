part of 'app_bloc.dart';

enum AppStatus {
  initial,
  error,
  loading,
  allInitiativesLoaded,
  changeInitiative,
  completedInitiative,
  supportInitiative,
  statsInitiative,
  singleInitiative,
  allBadges,
  allEntries,
  allNews,
  allEvents,
}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isAllBadges => this == AppStatus.allBadges;
  bool get isEntries => this == AppStatus.allEntries;
  bool get isNews => this == AppStatus.allNews;
  bool get isEvents => this == AppStatus.allEvents;
  bool get isAllInitiativesLoaded => this == AppStatus.allInitiativesLoaded;
  bool get isChangeInitiative => this == AppStatus.changeInitiative;
  bool get isCompletedInitiative => this == AppStatus.completedInitiative;
  bool get isSingleInitiative => this == AppStatus.singleInitiative;
  bool get isSupportInitiative => this == AppStatus.supportInitiative;
  bool get isStatsInitiative => this == AppStatus.statsInitiative;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.initiatives = const [],
    this.badges = const [],
    this.entries = const [],
    this.news = const [],
    this.events = const [],
    this.achievements = const [],
    this.initiative,
    this.singleInitiative,
    this.exception,
    this.token,
    this.userPosition,
    this.stats,
  });

  final String? token;
  final String? exception;
  final List<Initiative> initiatives;
  final List<Entry> entries;
  final List<NewsModel> news;
  final List<EventModel> events;
  final int? userPosition;
  final List<Badge> badges;
  final List<Achievement> achievements;
  final Initiative? initiative;
  final Initiative? singleInitiative;
  final StatsModel? stats;
  final AppStatus status;

  AppState copyWith({
    List<Initiative>? initiatives,
    StatsModel? stats,
    List<Entry>? entries,
    int? userPosition,
    AppStatus? status,
    Initiative? initiative,
    Initiative? singleInitiative,
    List<Badge>? badges,
    List<Achievement>? achievements,
    List<NewsModel>? news,
    List<EventModel>? events,
    String? exception,
    String? token,
  }) {
    return AppState(
      initiatives: initiatives ?? this.initiatives,
      stats: stats ?? this.stats,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      initiative: initiative ?? this.initiative,
      singleInitiative: singleInitiative ?? this.singleInitiative,
      badges: badges ?? this.badges,
      entries: entries ?? this.entries,
      userPosition: userPosition ?? this.userPosition,
      news: news ?? this.news,
      events: events ?? this.events,
      achievements: achievements ?? this.achievements,
    );
  }

  @override
  List<Object?> get props => [
        initiatives,
        exception,
        status,
        token,
        initiative,
        badges,
        entries,
        singleInitiative
      ];
}
