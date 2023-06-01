part of 'app_bloc.dart';

enum AppStatus {
  initial,
  error,
  loading,
  allInitiativesLoaded,
}

extension AppStatusX on AppStatus {
  bool get isInitial => this == AppStatus.initial;
  bool get isError => this == AppStatus.error;
  bool get isLoading => this == AppStatus.loading;
  bool get isAllInitiativesLoaded => this == AppStatus.allInitiativesLoaded;
}

class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.initiatives = const [],
    this.exception,
    this.token,
  });

  final String? token;
  final String? exception;
  final List<Initiative> initiatives;
  final AppStatus status;

  AppState copyWith({
    List<Initiative>? initiatives,
    AppStatus? status,
    String? exception,
    String? token,
  }) {
    return AppState(
      initiatives: initiatives ?? this.initiatives,
      status: status ?? this.status,
      exception: exception ?? this.exception,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [initiatives, exception, status, token];
}
