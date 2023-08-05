import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:easy_beck/mood_tracker/domain/usecase/log_mood.dart';
import 'package:easy_beck/mood_tracker/service/mood_tracker_event.dart';
import 'package:easy_beck/mood_tracker/service/mood_tracker_state.dart';

class MoodTrackerBloc extends Bloc<MoodTrackerEvent, MoodTrackerState> implements EventSink<MoodTrackerEvent> {
  MoodTrackerBloc(LogMood logMood) : super(const MoodTrackerState()) {
    on<MoodSelected>((event, emit) async {
      await logMood(event.level);
      emit(state.copyWith(selectedMoodLevel: event.level));
    });
  }
}
