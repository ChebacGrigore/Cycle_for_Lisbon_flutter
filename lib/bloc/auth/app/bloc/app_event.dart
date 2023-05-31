part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppListOfInitiatives extends AppEvent {
  final String token;
  const AppListOfInitiatives({required this.token});
}
