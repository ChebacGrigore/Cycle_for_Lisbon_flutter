import 'package:cfl/controller/app/achievements.dart';
import 'package:cfl/controller/app/initiative.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cfl/models/initiative.model.dart';
import 'package:equatable/equatable.dart';

import '../../../models/acheivement.model.dart';
import '../../../models/user.model.dart';
import '../../../shared/global/global_var.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final InitiativeService _initiative = InitiativeService();
  AppBloc() : super(const AppState()) {
    on<AppListOfInitiatives>(_onListOfInitiatives);
    on<AppChangeInitiative>(_onSelectedInitiative);
    on<AppCompletedInitiative>(_onCompletedInitiative);
    on<AppListOfBadges>(_onListOfBadges);
    on<AppLeaderboard>(_onLeaderboard);
    on<AppNews>(_onNews);
    on<AppEvents>(_onEvents);
    on<AppSupportInitiative>(_onSupportInitiative);
    on<AppSelectedInitiativeStats>(_onStatsInitiative);
    on<AppSingleInitiative>(_onSingleInitiative);
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

  void _onSupportInitiative(
      AppSupportInitiative event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final user = await _initiative.supportInitiative(
        user: event.userProfile,
        userId: event.userId,
        initiativeId: event.initiativeId,
        accessToken: event.token,
      );
      currentUser = user;
      emit(
        state.copyWith(status: AppStatus.supportInitiative),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onStatsInitiative(
      AppSelectedInitiativeStats event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final stats = await _initiative.getSelectedInitiativeStats(
        accessToken: event.token,
      );
      emit(
        state.copyWith(status: AppStatus.statsInitiative, stats: stats),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onSingleInitiative(
      AppSingleInitiative event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final initiative = await _initiative.getSingleInitiative(
        accessToken: event.token,
        id: event.id,
      );
      emit(
        state.copyWith(
            status: AppStatus.singleInitiative, singleInitiative: initiative),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onListOfBadges(AppListOfBadges event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final badges = await allAchievements(
        token: event.token,
      );
      if (badges.isEmpty) {
        final achievements = await getAllAchievements(
          token: event.token,
        );
        emit(
          state.copyWith(
            status: AppStatus.allBadges,
            badges: [],
            achievements: achievements,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: AppStatus.allBadges,
            badges: badges,
            achievements: [],
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onLeaderboard(AppLeaderboard event, Emitter<AppState> emit) async {
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

  void _onNews(AppNews event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final news = await _initiative.getAllNews(
        token: event.token,
      );
      emit(
        state.copyWith(
          status: AppStatus.allNews,
          news: news,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onEvents(AppEvents event, Emitter<AppState> emit) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final events = await _initiative.getAllEvents(
        token: event.token,
      );
      emit(
        state.copyWith(
          status: AppStatus.allEvents,
          events: events,
        ),
      );
    } catch (e) {
      emit(state.copyWith(exception: e.toString(), status: AppStatus.error));
    }
  }

  void _onSelectedInitiative(
      AppChangeInitiative event, Emitter<AppState> emit) async {
    try {
      emit(
        state.copyWith(status: AppStatus.changeInitiative),
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
