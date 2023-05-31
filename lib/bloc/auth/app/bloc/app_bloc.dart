import 'package:cfl/controller/app/initiative.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cfl/models/initiative.model.dart';
import 'package:equatable/equatable.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final InitiativeService _initiative = InitiativeService();
  AppBloc() : super(const AppState()) {
    on<AppListOfInitiatives>(_onListOfInitiatives);
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
}
