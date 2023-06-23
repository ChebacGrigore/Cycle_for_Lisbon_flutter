import 'package:cfl/controller/app/achievements.dart';
import 'package:cfl/controller/app/initiative.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cfl/models/initiative.model.dart';
import 'package:equatable/equatable.dart';

import '../../../models/acheivement.model.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final InitiativeService _initiative = InitiativeService();
  AppBloc() : super(const AppState()) {
    on<AppListOfInitiatives>(_onListOfInitiatives);
    on<AppSelectedInitiative>(_onSelectedInitiative);
    on<AppCompletedInitiative>(_onCompletedInitiative);
    on<AppListOfBadges>(_onListOfBadges);
    on<AppLeaderboard>(_onLeaderboard);
  }

  void _onListOfInitiatives(
      AppListOfInitiatives event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final initiatives = await _initiative.getInitiatives(
        accessToken: event.token,
      );
      emit(
        state.copyWith(
          status: AppStatus.allInitiativesLoaded,
          initiatives: initiatives,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onListOfBadges(
      AppListOfBadges event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final badges = await allAchievements(
        token: event.token,
      );
      print('Badges from bloc >>> ${badges.length}');
      emit(
        state.copyWith(
          status: AppStatus.allBadges,
          badges: badges,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onLeaderboard(
      AppLeaderboard event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final leader = await leaderboard(
        token: event.token,
      );
      print('Leaderboard from bloc >>> ${leader.entries.length}');
      emit(
        state.copyWith(
          status: AppStatus.allEntries,
          entries: leader.entries,
          userPosition: leader.userPosition,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onSelectedInitiative(
      AppSelectedInitiative event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      emit(
        state.copyWith(
          status: AppStatus.selectedInitiative,
          initiative: event.initiative,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onCompletedInitiative(
      AppCompletedInitiative event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      emit(
        state.copyWith(
          status: AppStatus.completedInitiative,
          initiative: event.initiative,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }
}
