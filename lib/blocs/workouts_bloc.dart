import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app_bloc/model_class/exerices.dart';
import 'package:gym_app_bloc/model_class/workout.dart';

class WorkoutsBloc extends Cubit<List<Workout>> {
  WorkoutsBloc() : super([]);
  getLoadData() async {
    final List<Workout> workoutList = [];
    final workoutJson =
        jsonDecode(await rootBundle.loadString("assets/workouts.json"));
    for (var element in (workoutJson as Iterable)) {
      workoutList.add(Workout.fromJson(element));
    }
    emit(workoutList);
  }

  saveWorkOut(Workout workout, int index) {
    Workout newWorkOut = Workout(title: workout.title, exercises: []);

    int exIndex = 0;
    int startTime = 0;
    for (var ex in workout.exercises) {
      newWorkOut.exercises.add(
        Exercise(
          title: ex.title,
          prelude: ex.prelude,
          duration: ex.duration,
          index: ex.index,
          startTime: ex.startTime,
        ),
      );
      exIndex++;
      startTime += ex.prelude! + ex.duration!;
    }
  }
}
