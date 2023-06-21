part of 'app_bloc.dart';

enum AppStatus {
  initial,
  error,
  loading,
  allInitiativesLoaded,
  selectedInitiative,
  completedInitiative,
}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isAllInitiativesLoaded => this == AppStatus.allInitiativesLoaded;
  bool get isSelectedInitiative => this == AppStatus.selectedInitiative;
  bool get isCompletedInitiative => this == AppStatus.completedInitiative;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.initiatives = const [],
    this.initiative,
    this.exception,
    this.token,
  });

  final String? token;
  final String? exception;
  final List<Initiative> initiatives;
  final Initiative? initiative;
  final AppStatus status;

  AppState copyWith({
    List<Initiative>? initiatives,
    AppStatus? status,
    Initiative? initiative,
    String? exception,
    String? token,
  }) {
    return AppState(
      initiatives: initiatives ?? this.initiatives,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
      initiative: initiative ?? this.initiative,
    );
  }

  @override
  List<Object?> get props =>
      [initiatives, exception, status, token, initiative];
}
