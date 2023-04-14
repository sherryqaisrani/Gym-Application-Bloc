import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_app_bloc/model_class/workout.dart';

class WorkoutsBloc extends Cubit<List<Workout>> {
  WorkoutsBloc(): super([]);
  getLoadData() async{
  final   List<Workout> workoutList = [];
   final workoutJson =   jsonDecode(await rootBundle.loadString("assets/workouts.json"));
   for (var element in (workoutJson as Iterable)) {
     workoutList.add(Workout.fromJson(element));
   }
   emit(workoutList);
  }
}